local vars = require("vars")
local mod, shiftMod = vars.mod, vars.shiftMod

local locked = { locked = true }
local mouse = { mouse = true }
local repeating = { repeating = true }
local locked_repeating = { locked = true, repeating = true }

-- Launcher / caelestia globals
hl.bind(mod .. " + " .. mod .. "_L", hl.dsp.global("caelestia:launcher"), { release = true })
hl.bind(mod .. " + N", hl.dsp.exec_cmd("caelestia shell drawers toggle dashboard"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("caelestia shell drawers toggle session"))
hl.bind(mod .. " + K", hl.dsp.exec_cmd("caelestia shell drawers toggle all"))
hl.bind("CTRL + ALT + C", hl.dsp.exec_cmd("caelestia shell notifications clear"))

-- Ventanas
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mod .. " + D", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("ALT + " .. mod .. " + SPACE", hl.dsp.window.float())
hl.bind(mod .. " + P", hl.dsp.window.pin())
hl.bind("ALT + F4", hl.dsp.window.close())

-- Foco / mover
for _, dir in ipairs({ "l", "r", "u", "d" }) do
    local key = ({ l = "Left", r = "Right", u = "Up", d = "Down" })[dir]
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = dir }))
    hl.bind(shiftMod .. " + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- Workspaces 1-9
for i = 1, 9 do
    local key = "code:1" .. tostring(i - 1)
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(shiftMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
    hl.bind("ALT + " .. mod .. " + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Apps
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(vars.terminal))
hl.bind(mod .. " + T", hl.dsp.exec_cmd(vars.terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(vars.fileExplorer))
hl.bind(mod .. " + W", hl.dsp.exec_cmd(vars.browser))
hl.bind(mod .. " + C", hl.dsp.exec_cmd(vars.editor))
hl.bind("CTRL + " .. mod .. " + V", hl.dsp.exec_cmd(vars.audioSettings))

-- Screenshot / utilidades
hl.bind(shiftMod .. " + S", hl.dsp.global("caelestia:screenshotFreeze"))
hl.bind(mod .. " + Print", hl.dsp.global("caelestia:screenshot"))
hl.bind("Print", hl.dsp.exec_cmd("caelestia screenshot"))
hl.bind(shiftMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
hl.bind(mod .. " + Period", hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))

-- Volumen
hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+"),
    locked_repeating)
hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
    locked_repeating)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), locked)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), locked)

-- Media
hl.bind("XF86AudioNext", hl.dsp.global("caelestia:mediaNext"), locked)
hl.bind("XF86AudioPrev", hl.dsp.global("caelestia:mediaPrev"), locked)
hl.bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), locked)
hl.bind("XF86AudioPause", hl.dsp.global("caelestia:mediaToggle"), locked)

-- Brillo
hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), locked)
hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), locked)

-- Lock / reload
hl.bind(mod .. " + L", function()
    hl.dispatch(hl.dsp.exec_cmd("caelestia shell -d"))
    hl.dispatch(hl.dsp.global("caelestia:lock"))
end, locked)

hl.bind("CTRL + " .. mod .. " + R",
    hl.dsp.exec_cmd("bash -c 'hyprctl reload; caelestia shell --kill; sleep .1; caelestia shell -d'"),
    { release = true })