return {
    -- Apps
    terminal = "uwsm app -- footclient",
    browser = "uwsm app -- zen-beta",
    editor = "uwsm app -- zeditor",
    fileExplorer = "uwsm app -- dolphin",
    audioSettings = "uwsm app -- pavucontrol",
    youtube = "uwsm app -- media-player",

    ---- Keybindings ----
    -- Core
    mod = "SUPER",
    shiftMod = "SUPER + SHIFT",

    kbGoToWs = "SUPER",
    kbGoToWsGroup = "CTRL + SUPER",
    kbMoveWinToWs = "SUPER + SHIFT",
    kbMoveWinToWsSilent = "SUPER + ALT",
    kbMoveWinToWsGroup = "CTRL + SUPER + ALT",

    -- Workspaces
    kbMoveWinToWsSpecial = { "SUPER + ALT + S", "CTRL + SUPER + SHIFT + Up" },
    kbMoveWinFromWsSpecial = "CTRL + SUPER + SHIFT + Down",
    kbMoveWinToWsNext = { "SUPER + ALT + mouse_down", "SUPER + ALT + Page_Down", "CTRL + SUPER + SHIFT + Right", "SUPER + SHIFT + mouse_down" },
    kbMoveWinToWsPrev = { "SUPER + ALT + mouse_up", "SUPER + ALT + Page_Up", "CTRL + SUPER + SHIFT + Left", "SUPER + SHIFT + mouse_up" },
    kbNextWs = { "SUPER + mouse_down", "CTRL + SUPER + Right", "SUPER + Page_Down" },
    kbPrevWs = { "SUPER + mouse_up", "CTRL + SUPER + Left", "SUPER + Page_Up" },
    kbNextWsGroup = "CTRL + SUPER + mouse_down",
    kbPrevWsGroup = "CTRL + SUPER + mouse_up",

    -- Window Group / Cycle
    kbWindowCycleNext = "ALT + TAB",
    kbWindowCyclePrev = "SHIFT + ALT + TAB",
    kbWindowGroupCycleNext = "CTRL + ALT + TAB",
    kbWindowGroupCyclePrev = "CTRL + SHIFT + ALT + TAB",
    kbUngroup = "SUPER + U",
    kbToggleGroup = "SUPER + Comma",
    kbGroupLockActive = "SUPER + SHIFT + Comma",

    -- Window Actions
    kbWindowDecreaseWidth = { "SUPER + Minus", "SUPER + ALT + Left", "SUPER + semicolon" },
    kbWindowIncreaseWidth = { "SUPER + Equal", "SUPER + ALT + Right", "SUPER + apostrophe" },
    kbWindowDecreaseHeight = { "SUPER + SHIFT + Minus", "SUPER + ALT + Up" },
    kbWindowIncreaseHeight = { "SUPER + SHIFT + Equal", "SUPER + ALT + Down" },

    kbMoveWindow = "SUPER + mouse:272",
    kbResizeWindow = "SUPER + mouse:273",
    kbCenterWindow = "CTRL + SUPER + Backslash",
    kbNormalizeWindow = "CTRL + SUPER + ALT + Backslash",
    kbWindowPip = "SUPER + ALT + Backslash",
    kbPinWindow = "SUPER + P",
    kbWindowFullscreen = "SUPER + D",
    kbWindowBorderedFullscreen = "SUPER + F",
    kbToggleWindowFloating = "SUPER + ALT + Space",
    kbCloseWindow = { "SUPER + Q", "ALT + F4" },

    -- Special workspaces toggles
    kbSpecialWs = "SUPER + S",
    kbSystemMonitorWs = "CTRL + SHIFT + Escape",
    kbMusicWs = "SUPER + M",
    kbCommunicationWs = "SUPER + SHIFT + D",
    kbTodoWs = "SUPER + R",

    -- Apps Binds
    kbTerminal = { "SUPER + Return", "SUPER + T", "CTRL + ALT + T" },
    kbBrowser = "SUPER + W",
    kbEditor = "SUPER + C",
    kbFileExplorer = "SUPER + E",
    kbAudioSettings = "CTRL + SUPER + V",
    kbYouTube = "SUPER + Y",

    -- Utilities
    kbScreenshot = "Print",
    kbScreenshotFreeze = "SUPER + SHIFT + S",
    kbScreenshotRegion = { "SUPER + Print", "SUPER + SHIFT + Print" },
    kbRecord = "CTRL + ALT + R",
    kbRecordSound = "SUPER + ALT + R",
    kbRecordRegion = "SUPER + SHIFT + ALT + R",
    kbColorPicker = "SUPER + SHIFT + C",

    -- Media
    kbMediaToggle = { "CTRL + SUPER + Space", "SUPER + SHIFT + P" },
    kbMediaNext = { "CTRL + SUPER + Equal", "SUPER + SHIFT + N" },
    kbMediaPrev = { "CTRL + SUPER + Minus", "SUPER + SHIFT + B" },
    kbMediaStop = "CTRL + SUPER + Backspace",
    kbVolumeMute = "SUPER + SHIFT + M",

    -- Misc / Shell
    kbLauncher = "SUPER + SUPER_L",
    kbSession = "CTRL + ALT + Delete",
    kbShowSidebar = "SUPER + N",
    kbClearNotifs = "CTRL + ALT + C",
    kbShowPanels = "SUPER + K",
    kbLock = "SUPER + L",
    kbRestoreLock = "SUPER + ALT + L",
    kbSleep = "SUPER + SHIFT + Escape",

    -- Clipboard & Emoji
    kbClipboard = "SUPER + V",
    kbClipboardDel = "SUPER + ALT + V",
    kbClipboardPasteLatest = "CTRL + SHIFT + ALT + V",
    kbEmoji = "SUPER + Period",

    -- Zoom
    kbZoomOut = "SUPER + minus",
    kbZoomIn = "SUPER + equal",

    -- Audio volume defaults
    volumeMax = 150,
    volumeStep = 2,
}