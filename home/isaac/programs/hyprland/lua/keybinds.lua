local vars = require("vars")
local fn = require("utils.functions")

-- Flags
local locked = { locked = true }
local mouse = { mouse = true }
local release = { release = true }
local repeating = { repeating = true }
local locked_repeating = { locked = true, repeating = true }

local function normalise_keybind(key)
  return key:gsub("%s+", ""):lower()
end

local function valid_keybind(key)
  return type(key) == "string" and key:match("%S") ~= nil
end

local function repeating_unless_mouse(key)
    return not normalise_keybind(key):find("mouse", 1, true) and repeating or nil
end

local function flatten_keybinds(keybinds, keys)
  keys = keys or {}

  if type(keybinds) == "table" then
    for _, keybinds in pairs(keybinds) do
      flatten_keybinds(keybinds, keys)
    end
  elseif valid_keybind(keybinds) then
    keys[#keys + 1] = keybinds
  end

  return keys
end

local function create_bind(keybinds, action, flags)
    local get_flags = type(flags) == "function" and flags or function()
        return flags
    end

    for _, key in ipairs(flatten_keybinds(keybinds)) do
        hl.bind(key, action, get_flags(key))
    end	
end

local function extend_keybind(base, suffix)
    return valid_keybind(base) and base .. " + " .. suffix or nil
end

-- Launcher 
local launcher_default = normalise_keybind("SUPER + SUPER_L")
create_bind(
    vars.kbLauncher,
    hl.dsp.global("caelestia:launcher"),
    function(key)
        return normalise_keybind(key) == launcher_default and release or nil
    end
)

-- Caelestia globals
create_bind(vars.kbClearNotifs, hl.dsp.global("caelestia:clearNotifs"), locked)
create_bind(vars.kbLock, hl.dsp.global("caelestia:lock"))
create_bind(vars.kbShowPanels, hl.dsp.global("caelestia:showall"))
create_bind(vars.kbShowSidebar, hl.dsp.global("caelestia:sidebar"))
create_bind(vars.kbSession, hl.dsp.global("caelestia:session"))

-- Workspaces 1-10
for i = 1, 10 do
    local key = i % 10

    create_bind(extend_keybind(vars.kbGoToWs, key), hl.dsp.focus({ workspace = i }))
    create_bind(extend_keybind(vars.kbMoveWinToWs, key), hl.dsp.window.move({ workspace = i }))
    create_bind(extend_keybind(vars.kbMoveWinToWsSilent, key), hl.dsp.window.move({ workspace = i, follow = false }))
    create_bind(extend_keybind(vars.kbGoToWsGroup, key), fn.wsaction("focus", "group", i))
    create_bind(extend_keybind(vars.kbMoveWinToWsGroup, key), fn.wsaction("move", "group", i))
end

-- Workspaces Navegation
create_bind(vars.kbPrevWs, hl.dsp.focus({ workspace = "-1" }), repeating_unless_mouse)
create_bind(vars.kbNextWs, hl.dsp.focus({ workspace = "+1" }), repeating_unless_mouse)
create_bind(vars.kbMoveWinToWsNext, hl.dsp.window.move({ workspace = "r+1" }), repeating_unless_mouse)
create_bind(vars.kbMoveWinToWsPrev, hl.dsp.window.move({ workspace = "r-1" }), repeating_unless_mouse)
create_bind("ALT + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Focus
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    local key = dir:sub(1, 1):upper() .. dir:sub(2)
    create_bind(vars.mod .. " + " .. key, hl.dsp.focus({ direction = dir:sub(1, 1) }))
    create_bind(vars.shiftMod .. " + " .. key, hl.dsp.window.move({ direction = dir:sub(1, 1) }))
end

-- Movimiento estilo Vim (HJKL)
create_bind(vars.shiftMod .. " + H", hl.dsp.window.move({ direction = "l" }))
create_bind(vars.shiftMod .. " + L", hl.dsp.window.move({ direction = "r" }))
create_bind(vars.shiftMod .. " + K", hl.dsp.window.move({ direction = "u" }))
create_bind(vars.shiftMod .. " + J", hl.dsp.window.move({ direction = "d" }))

-- Grupos de Ventanas
create_bind(vars.kbWindowCycleNext, hl.dsp.window.cycle_next(), repeating)
create_bind(vars.kbWindowCyclePrev, hl.dsp.window.cycle_next({ next = false }), repeating)
create_bind(vars.kbWindowGroupCycleNext, hl.dsp.group.next(), repeating)
create_bind(vars.kbWindowGroupCyclePrev, hl.dsp.group.prev(), repeating)
create_bind(vars.kbToggleGroup, hl.dsp.group.toggle())
create_bind(vars.kbUngroup, hl.dsp.window.move({ out_of_group = true }))
create_bind(vars.kbGroupLockActive, hl.dsp.group.lock())

-- Acciones de Ventana
create_bind(vars.kbWindowDecreaseWidth, hl.dsp.layout("splitratio -0.1"), repeating)
create_bind(vars.kbWindowIncreaseWidth, hl.dsp.layout("splitratio +0.1"), repeating)
create_bind(vars.kbMoveWindow, hl.dsp.window.drag(), mouse)
create_bind(vars.kbResizeWindow, hl.dsp.window.resize(), mouse)
create_bind(vars.kbPinWindow, hl.dsp.window.pin())
create_bind(vars.kbWindowFullscreen, hl.dsp.window.fullscreen({ mode = "fullscreen" }))
create_bind(vars.kbWindowBorderedFullscreen, hl.dsp.window.fullscreen({ mode = "maximized" }))
create_bind(vars.kbToggleWindowFloating, hl.dsp.window.float())
create_bind(vars.kbCloseWindow, hl.dsp.window.close())

-- Scratchpad / Special Workspaces
create_bind(vars.kbSpecialWs, hl.dsp.workspace.toggle_special())
create_bind(vars.kbMoveWinToWsSpecial, hl.dsp.window.move({ workspace = "special:special", follow = false }))
create_bind(vars.kbMusicWs, hl.dsp.workspace.toggle_special("music"))
create_bind(vars.kbCommunicationWs, hl.dsp.workspace.toggle_special("communication"))

-- Apps
create_bind(vars.kbTerminal, hl.dsp.exec_cmd(vars.terminal))
create_bind(vars.kbBrowser, hl.dsp.exec_cmd(vars.browser))
create_bind(vars.kbEditor, hl.dsp.exec_cmd(vars.editor))
create_bind(vars.kbFileExplorer, hl.dsp.exec_cmd(vars.fileExplorer))
create_bind(vars.kbAudioSettings, hl.dsp.exec_cmd(vars.audioSettings))
create_bind(vars.kbYouTube, hl.dsp.exec_cmd(vars.youtube))

-- Screenshots / Utilidades
create_bind(vars.kbScreenshot, hl.dsp.exec_cmd("caelestia screenshot"))
create_bind(vars.kbScreenshotFreeze, hl.dsp.global("caelestia:screenshotFreeze"))
create_bind(vars.kbScreenshotRegion, hl.dsp.global("caelestia:screenshot"))
create_bind(vars.kbRecord, hl.dsp.exec_cmd("caelestia record"))
create_bind(vars.kbColorPicker, hl.dsp.exec_cmd("hyprpicker -a"))
create_bind(vars.kbClipboard, hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
create_bind(vars.kbEmoji, hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))

-- Control de Audio (WirePlumber)
create_bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+"),
    locked_repeating
)
create_bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
    locked_repeating
)
create_bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), locked)
create_bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), locked)

-- Control de Media
create_bind({ vars.kbMediaToggle, "XF86AudioPlay", "XF86AudioPause" }, hl.dsp.global("caelestia:mediaToggle"), locked)
create_bind({ vars.kbMediaNext, "XF86AudioNext" }, hl.dsp.global("caelestia:mediaNext"), locked)
create_bind({ vars.kbMediaPrev, "XF86AudioPrev" }, hl.dsp.global("caelestia:mediaPrev"), locked)

-- Brillo
create_bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), locked)
create_bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), locked)

-- Suspensión
create_bind(vars.kbSleep, hl.dsp.exec_cmd("sleep-now"), locked)

-- Zoom del cursor
create_bind(
    vars.kbZoomOut,
    hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 - 0.1}')"),
    repeating
)
create_bind(
    vars.kbZoomIn,
    hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 + 0.1}')"),
    repeating
)

-- Recargar Shell y Hyprland
create_bind(
    "CTRL + SUPER + R",
    hl.dsp.exec_cmd("bash -c 'hyprctl reload; caelestia shell --kill; sleep .1; caelestia shell -d'"),
    release
)