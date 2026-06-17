{ lib, ... }:
let
  totalWorkspaces = 9;

  workspaceBinds = lib.concatStrings (builtins.genList (i:
    let ws = toString (i + 1);
    in ''
      hl.bind("SUPER + code:1${toString i}", hl.dsp.focus({ workspace = "${ws}" }))
      hl.bind("SUPER + SHIFT + code:1${toString i}", hl.dsp.window.move({ workspace = "${ws}" }))
      hl.bind("SUPER + ALT + code:1${toString i}", hl.dsp.window.move({ workspace = "${ws}", follow = false }))
    ''
  ) totalWorkspaces);
in
{
  wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
    -- --- ATADOS ESTÁNDAR (bind) ---
    hl.bind("SUPER + Q", hl.dsp.window.close())
    hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
    hl.bind("SUPER + D", hl.dsp.window.fullscreen({ mode = "maximized" }))
    hl.bind("ALT + SUPER + SPACE", hl.dsp.window.float({ action = "toggle" }))
    hl.bind("SUPER + P", hl.dsp.window.pin({ action = "toggle" }))
    hl.bind("ALT + F4", hl.dsp.window.close())
    hl.bind("ALT + TAB", hl.dsp.focus({ workspace = "previous" }))

    -- Foco con flechas
    hl.bind("SUPER + Left", hl.dsp.focus({ direction = "left" }))
    hl.bind("SUPER + Right", hl.dsp.focus({ direction = "right" }))
    hl.bind("SUPER + Up", hl.dsp.focus({ direction = "up" }))
    hl.bind("SUPER + Down", hl.dsp.focus({ direction = "down" }))

    -- Mover ventanas con flechas
    hl.bind("SUPER + SHIFT + Left", hl.dsp.window.move({ direction = "left" }))
    hl.bind("SUPER + SHIFT + Right", hl.dsp.window.move({ direction = "right" }))
    hl.bind("SUPER + SHIFT + Up", hl.dsp.window.move({ direction = "up" }))
    hl.bind("SUPER + SHIFT + Down", hl.dsp.window.move({ direction = "down" }))

    -- Mover ventanas vim-style
    hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
    hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
    hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
    hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

    -- Workspaces con flechas / mouse
    hl.bind("CTRL + SUPER + Right", hl.dsp.focus({ workspace = "r+1" }))
    hl.bind("CTRL + SUPER + Left", hl.dsp.focus({ workspace = "r-1" }))
    hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "+1" }))
    hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "-1" }))

    -- Mover ventana a workspace con mouse
    hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "r-1" }))
    hl.bind("SUPER + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "r+1" }))

    -- Scratchpad
    hl.bind("SUPER + S", hl.dsp.workspace.toggle_special())
    hl.bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special", follow = false }))

    -- Split ratio
    hl.bind("SUPER + semicolon", hl.dsp.layout("splitratio -0.1"))
    hl.bind("SUPER + apostrophe", hl.dsp.layout("splitratio +0.1"))

    -- Apps (uwsm)
    hl.bind("SUPER + Return", hl.dsp.exec_cmd("uwsm app -- foot"))
    hl.bind("SUPER + T", hl.dsp.exec_cmd("uwsm app -- foot"))
    hl.bind("CTRL + ALT + T", hl.dsp.exec_cmd("uwsm app -- foot"))
    hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm app -- dolphin"))
    hl.bind("SUPER + W", hl.dsp.exec_cmd("uwsm app -- zen-beta"))
    hl.bind("SUPER + C", hl.dsp.exec_cmd("uwsm app -- zeditor"))
    hl.bind("CTRL + SUPER + V", hl.dsp.exec_cmd("uwsm app -- pavucontrol"))

    -- Caelestia shell
    hl.bind("SUPER + N", hl.dsp.exec_cmd("caelestia shell drawers toggle dashboard"))
    hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("caelestia shell drawers toggle session"))
    hl.bind("SUPER + K", hl.dsp.exec_cmd("caelestia shell drawers toggle all"))
    hl.bind("CTRL + ALT + C", hl.dsp.exec_cmd("caelestia shell notifications clear"))

    -- Screenshot
    hl.bind("SUPER + SHIFT + S", hl.dsp.global("caelestia:screenshotFreeze"))
    hl.bind("SUPER + Print", hl.dsp.global("caelestia:screenshot"))
    hl.bind("SUPER + SHIFT + Print", hl.dsp.global("caelestia:screenshot"))
    hl.bind("Print", hl.dsp.exec_cmd("caelestia screenshot"))

    -- Color picker
    hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

    -- Clipboard and emoji picker
    hl.bind("SUPER + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
    hl.bind("SUPER + Period", hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))

    -- Generación dinámica de Workspaces
    ${workspaceBinds}
    -- --- CONTROLES DE MOUSE (drag/resize) ---
    hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
    hl.bind("SUPER + mouse:274", hl.dsp.window.drag())
    hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

    -- --- REPETICIÓN CON EVENTOS DE BLOQUEO (bindel) ---
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"), { locked = true, repeating = true })

    -- --- EVENTOS DE BLOQUEO PURO (bindl) ---
    hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), { locked = true })
    hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
    hl.bind("ALT + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
    hl.bind("XF86AudioNext", hl.dsp.global("caelestia:mediaNext"), { locked = true })
    hl.bind("XF86AudioPrev", hl.dsp.global("caelestia:mediaPrev"), { locked = true })
    hl.bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
    hl.bind("SUPER + SHIFT + N", hl.dsp.global("caelestia:mediaNext"), { locked = true })
    hl.bind("SUPER + SHIFT + B", hl.dsp.global("caelestia:mediaPrev"), { locked = true })
    hl.bind("SUPER + SHIFT + P", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
    hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), { locked = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), { locked = true })
    hl.bind("SUPER + L", function()
      hl.dispatch(hl.dsp.exec_cmd("caelestia shell -d"))
      hl.dispatch(hl.dsp.global("caelestia:lock"))
    end, { locked = true })
    hl.bind("SUPER + SHIFT + Escape", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })

    -- --- REPETICIÓN NORMAL (binde) ---
    hl.bind("SUPER + minus", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 - 0.1}')"), { repeating = true })
    hl.bind("SUPER + equal", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 + 0.1}')"), { repeating = true })

    -- --- EVENTOS AL SOLTAR LA TECLA (bindr) ---
    hl.bind("CTRL + SUPER + R", hl.dsp.exec_cmd("bash -c 'hyprctl reload; caelestia shell --kill; sleep .1; caelestia shell -d'"), { release = true })
  '';
}
