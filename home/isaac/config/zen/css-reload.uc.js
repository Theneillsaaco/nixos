// CSS Auto Hot Reload for Zen Browser
(function() {
  console.log("[CSS-Reload] Script loaded");

  try {
    const profileDir = Services.dirsvc.get("ProfD", Ci.nsIFile);
    const chromeDir = profileDir.clone();
    chromeDir.append("chrome");

    const userChromeFile = chromeDir.clone();
    userChromeFile.append("userChrome.css");

    const userContentFile = chromeDir.clone();
    userContentFile.append("userContent.css");

    let lastMtimeChrome = 0;
    let lastMtimeContent = 0;

    let chromeSheetURI = null;
    let contentSheetURI = null;

    const io = Cc["@mozilla.org/network/io-service;1"].getService(Ci.nsIIOService);

    function initializeSheetURIs() {
      try {
        if (userChromeFile.exists()) {
          chromeSheetURI = io.newFileURI(userChromeFile);
          console.log("[CSS-Reload] Chrome URI: " + chromeSheetURI.spec);
        }
        if (userContentFile.exists()) {
          contentSheetURI = io.newFileURI(userContentFile);
          console.log("[CSS-Reload] Content URI: " + contentSheetURI.spec);
        }
      } catch (e) {
        console.error("[CSS-Reload] Error initializing URIs: " + e.message);
      }
    }

    function getBustedURI(baseURI) {
      return io.newURI(baseURI.spec + "?t=" + Date.now());
    }

    function reloadChromeCSSInAllWindows() {
      if (!chromeSheetURI) return;
      const wm = Cc["@mozilla.org/appshell/window-mediator;1"].getService(Ci.nsIWindowMediator);
      const browserEnum = wm.getEnumerator(null);

      while (browserEnum.hasMoreElements()) {
        const win = browserEnum.getNext();
        if (!win.windowUtils) continue;
        try {
          win.windowUtils.removeSheet(chromeSheetURI, win.windowUtils.USER_SHEET);
          win.windowUtils.loadSheet(getBustedURI(chromeSheetURI), win.windowUtils.USER_SHEET);
          console.log("[CSS-Reload] ✓ Chrome reloaded: " + win.location.href);
        } catch (e) {
          console.error("[CSS-Reload] Chrome reload error: " + e.message);
        }
      }
    }

    // ── NEW: inject the latest busted sheet into a single browser element ──
    function injectContentSheetIntoBrowser(browser) {
      if (!contentSheetURI) return;
      try {
        const cWin = browser.contentWindow;
        if (!cWin || !cWin.windowUtils) return;
        const utils = cWin.windowUtils;
        try { utils.removeSheet(contentSheetURI, utils.USER_SHEET); } catch (_) {}
        utils.loadSheet(getBustedURI(contentSheetURI), utils.USER_SHEET);
        console.log("[CSS-Reload] ✓ Content injected on load: " + (browser.currentURI?.spec || "?"));
      } catch (e) {
        console.error("[CSS-Reload] injectContentSheetIntoBrowser error: " + e.message);
      }
    }

    function reloadContentCSS() {
      if (!contentSheetURI) return;

      try {
        const ss = Cc["@mozilla.org/content/style-sheet-service;1"].getService(Ci.nsIStyleSheetService);
        if (ss.sheetRegistered(contentSheetURI, ss.USER_SHEET)) {
          ss.unregisterSheet(contentSheetURI, ss.USER_SHEET);
        }
        ss.loadAndRegisterSheet(contentSheetURI, ss.USER_SHEET);
        console.log("[CSS-Reload] ✓ Global content sheet re-registered");
      } catch (e) {
        console.error("[CSS-Reload] Global content sheet error: " + e.message);
      }

      const wm = Cc["@mozilla.org/appshell/window-mediator;1"].getService(Ci.nsIWindowMediator);
      const browserEnum = wm.getEnumerator("navigator:browser");

      while (browserEnum.hasMoreElements()) {
        const win = browserEnum.getNext();
        const tabBrowser = win.gBrowser;
        if (!tabBrowser) continue;

        for (const browser of tabBrowser.browsers) {
          injectContentSheetIntoBrowser(browser);
        }
      }
    }

    function attachTabListeners(win) {
      const tabBrowser = win.gBrowser;
      if (!tabBrowser) return;

      // Use DOMContentLoaded at capture phase — fires earlier and catches about: privileged pages
      tabBrowser.addEventListener("DOMContentLoaded", function onDOMLoaded(event) {
        const doc = event.target;
        const docURI = doc?.documentURI || "";

        // Only handle top-level documents, not iframes/sub-resources
        if (doc?.defaultView?.top !== doc?.defaultView) return;

        // Small delay so the content window's windowUtils is fully ready
        win.setTimeout(() => {
          let injected = false;

          for (const browser of tabBrowser.browsers) {
            try {
              const cWin = browser.contentWindow;
              if (!cWin || !cWin.windowUtils) continue;

              // Match by document URI to target only the tab that just loaded
              if (cWin.document?.documentURI === docURI || !injected) {
                injectContentSheetIntoBrowser(browser);
                injected = true;
              }
            } catch (e) {
              console.error("[CSS-Reload] DOMContentLoaded inject error: " + e.message);
            }
          }
        }, 100);

      }, true);

      console.log("[CSS-Reload] ✓ Tab load listener attached to window");
    }

    function checkFiles() {
      try {
        if (userChromeFile.exists()) {
          const mtime = userChromeFile.lastModifiedTime;
          if (lastMtimeChrome > 0 && mtime !== lastMtimeChrome) {
            console.log("[CSS-Reload] userChrome.css changed!");
            reloadChromeCSSInAllWindows();
          }
          lastMtimeChrome = mtime;
        }

        if (userContentFile.exists()) {
          const mtime = userContentFile.lastModifiedTime;
          if (lastMtimeContent > 0 && mtime !== lastMtimeContent) {
            console.log("[CSS-Reload] userContent.css changed!");
            reloadContentCSS();
          }
          lastMtimeContent = mtime;
        }
      } catch (e) {
        console.error("[CSS-Reload] checkFiles error: " + e.message);
      }
    }

    initializeSheetURIs();

    try {
      if (userChromeFile.exists()) lastMtimeChrome = userChromeFile.lastModifiedTime;
      if (userContentFile.exists()) lastMtimeContent = userContentFile.lastModifiedTime;
    } catch (e) {
      console.error("[CSS-Reload] Init error: " + e.message);
    }

    // Attach listeners to all currently open windows
    const wm = Cc["@mozilla.org/appshell/window-mediator;1"].getService(Ci.nsIWindowMediator);
    const existingWindows = wm.getEnumerator("navigator:browser");
    while (existingWindows.hasMoreElements()) {
      attachTabListeners(existingWindows.getNext());
    }

    // Also attach to any new browser windows that open later
    wm.addListener({
      onOpenWindow(xulWin) {
        const win = xulWin.docShell.domWindow;
        win.addEventListener("load", () => attachTabListeners(win), { once: true });
      },
      onCloseWindow() {},
      onWindowTitleChange() {}
    });

    setInterval(checkFiles, 1000);
    console.log("[CSS-Reload] ✓ Monitor active");

  } catch (e) {
    console.error("[CSS-Reload] Fatal: " + e.message);
  }
})();
