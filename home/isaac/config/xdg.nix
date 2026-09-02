{ 
  xdg = {
    desktopEntries = {
      zen = {
        name = "Zen Browser";
        exec = "firejail zen %U";
        icon = "zen-browser";
        terminal = false;
        categories = [ "Network" "WebBrowser" ];
        mimeType = [
          "text/html"
          "text/xml"
          "application/xhtml+xml"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
        ];
      };
      discord = {
        name = "Discord";
        exec = "firejail discord";
        icon = "discord";
        terminal = false;
        categories = [ "Network" "InstantMessaging" ];
      };
    };
    
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "org.kde.dolphin.desktop";

        "text/html" = [ "zen.desktop" ];
        "text/xml" = [ "zen.desktop" ];
        "application/xhtml+xml" = [ "zen.desktop" ];
        "application/x-xpinstall" = [ "zen.desktop" ];
        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
      };
    };
  };

  home.sessionVariables = {
    BROWSER = "firejail zen";
    DEFAULT_BROWSER = "firejail zen";
  };
}