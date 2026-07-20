{ lib, ... }:
let
  inline = lib.generators.mkLuaInline;
  # Bind simple: key string literal, dispatcher inline
  b = key: dispatcher: {
    _args = [ (inline key) (inline dispatcher) ];
  };
  # Bind con flags
  bf = key: dispatcher: flags: {
    _args = [ (inline key) (inline dispatcher) flags ];
  };
in
{
  wayland.windowManager.hyprland.settings.bind =
    [
      # Launcher de Caelestia — confirmado desde el código oficial de Caelestia:
      # hl.bind("SUPER + SUPER_L", hl.dsp.global("caelestia:launcher"), { release = true })
      # NO usa submap, solo un bind directo con { release = true }
      (bf ''"SUPER + SUPER_L"''     ''hl.dsp.global("caelestia:launcher")''  { release = true; })

      # Ventanas
      (b  ''mod .. " + Q"''         ''hl.dsp.window.close()'')
      (b  ''mod .. " + F"''         ''hl.dsp.window.fullscreen({ mode = "maximized" })'')
      (b  ''mod .. " + D"''         ''hl.dsp.window.fullscreen({ mode = "fullscreen" })'')
      (b  ''"ALT + " .. mod .. " + SPACE"'' ''hl.dsp.window.float()'') # sin args = toggle
      (b  ''mod .. " + P"''         ''hl.dsp.window.pin()'')
      (b  ''"ALT + F4"''            ''hl.dsp.window.close()'')

      # Workspaces — confirmado: hl.dsp.focus({ workspace = X })
      (b  ''"ALT + TAB"''           ''hl.dsp.focus({ workspace = "previous" })'')
      (b  ''"CTRL + " .. mod .. " + Right"'' ''hl.dsp.focus({ workspace = "r+1" })'')
      (b  ''"CTRL + " .. mod .. " + Left"''  ''hl.dsp.focus({ workspace = "r-1" })'')
      (b  ''mod .. " + mouse_up"''  ''hl.dsp.focus({ workspace = "+1" })'')
      (b  ''mod .. " + mouse_down"'' ''hl.dsp.focus({ workspace = "-1" })'')

      # Mover ventana a workspace con scroll
      (b  ''shiftMod .. " + mouse_down"'' ''hl.dsp.window.move({ workspace = "r-1" })'')
      (b  ''shiftMod .. " + mouse_up"''   ''hl.dsp.window.move({ workspace = "r+1" })'')

      # Foco direccional
      (b  ''mod .. " + Left"''      ''hl.dsp.focus({ direction = "l" })'')
      (b  ''mod .. " + Right"''     ''hl.dsp.focus({ direction = "r" })'')
      (b  ''mod .. " + Up"''        ''hl.dsp.focus({ direction = "u" })'')
      (b  ''mod .. " + Down"''      ''hl.dsp.focus({ direction = "d" })'')

      # Mover ventanas
      (b  ''shiftMod .. " + Left"''  ''hl.dsp.window.move({ direction = "l" })'')
      (b  ''shiftMod .. " + Right"'' ''hl.dsp.window.move({ direction = "r" })'')
      (b  ''shiftMod .. " + Up"''    ''hl.dsp.window.move({ direction = "u" })'')
      (b  ''shiftMod .. " + Down"''  ''hl.dsp.window.move({ direction = "d" })'')
      (b  ''shiftMod .. " + H"''     ''hl.dsp.window.move({ direction = "l" })'')
      (b  ''shiftMod .. " + L"''     ''hl.dsp.window.move({ direction = "r" })'')
      (b  ''shiftMod .. " + K"''     ''hl.dsp.window.move({ direction = "u" })'')
      (b  ''shiftMod .. " + J"''     ''hl.dsp.window.move({ direction = "d" })'')

      # Scratchpad / special workspace
      (b  ''mod .. " + S"''         ''hl.dsp.workspace.toggle_special()'')
      (b  ''"ALT + " .. mod .. " + S"'' ''hl.dsp.window.move({ workspace = "special", silent = true })'')

      # Master layout split ratio
      (b  ''mod .. " + semicolon"''  ''hl.dsp.layout("splitratio -0.1")'')
      (b  ''mod .. " + apostrophe"'' ''hl.dsp.layout("splitratio +0.1")'')

      # Apps
      (b  ''mod .. " + Return"''    ''hl.dsp.exec_cmd("uwsm app -- foot")'')
      (b  ''mod .. " + T"''         ''hl.dsp.exec_cmd("uwsm app -- foot")'')
      (b  ''"CTRL + ALT + T"''      ''hl.dsp.exec_cmd("uwsm app -- foot")'')
      (b  ''mod .. " + E"''         ''hl.dsp.exec_cmd("uwsm app -- dolphin")'')
      (b  ''mod .. " + W"''         ''hl.dsp.exec_cmd("uwsm app -- zen-beta")'')
      (b  ''mod .. " + C"''         ''hl.dsp.exec_cmd("uwsm app -- zeditor")'')
      (b  ''"CTRL + " .. mod .. " + V"'' ''hl.dsp.exec_cmd("uwsm app -- pavucontrol")'')

      # Caelestia shell
      (b  ''mod .. " + N"''           ''hl.dsp.exec_cmd("caelestia shell drawers toggle dashboard")'')
      (b  ''"CTRL + ALT + Delete"''   ''hl.dsp.exec_cmd("caelestia shell drawers toggle session")'')
      (b  ''mod .. " + K"''           ''hl.dsp.exec_cmd("caelestia shell drawers toggle all")'')
      (b  ''"CTRL + ALT + C"''        ''hl.dsp.exec_cmd("caelestia shell notifications clear")'')

      # Screenshot
      (b  ''shiftMod .. " + S"''     ''hl.dsp.global("caelestia:screenshotFreeze")'')
      (b  ''mod .. " + Print"''      ''hl.dsp.global("caelestia:screenshot")'')
      (b  ''shiftMod .. " + Print"'' ''hl.dsp.global("caelestia:screenshot")'')
      (b  ''"Print"''                ''hl.dsp.exec_cmd("caelestia screenshot")'')

      # Utilidades
      (b  ''shiftMod .. " + C"'' ''hl.dsp.exec_cmd("hyprpicker -a")'')
      (b  ''mod .. " + V"''      ''hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard")'')
      (b  ''mod .. " + Period"'' ''hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p")'')

      # Ratón (drag/resize)
      (bf ''mod .. " + mouse:272"'' ''hl.dsp.window.drag()''   { mouse = true; })
      (bf ''mod .. " + mouse:274"'' ''hl.dsp.window.drag()''   { mouse = true; })
      (bf ''mod .. " + mouse:273"'' ''hl.dsp.window.resize()'' { mouse = true; })

      # Volumen (repeating + locked)
      (bf ''"XF86AudioRaiseVolume"''
          ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+")''
          { locked = true; repeating = true; })
      (bf ''"XF86AudioLowerVolume"''
          ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-")''
          { locked = true; repeating = true; })

      # Audio (locked)
      (bf ''"XF86AudioMute"''    ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'' { locked = true; })
      (bf ''"XF86AudioMicMute"'' ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")'' { locked = true; })

      # Media player — confirmado desde Caelestia: hl.dsp.global("caelestia:media*")
      (bf ''"XF86AudioNext"''  ''hl.dsp.global("caelestia:mediaNext")''   { locked = true; })
      (bf ''"XF86AudioPrev"''  ''hl.dsp.global("caelestia:mediaPrev")''   { locked = true; })
      (bf ''"XF86AudioPlay"''  ''hl.dsp.global("caelestia:mediaToggle")'' { locked = true; })
      (bf ''"XF86AudioPause"'' ''hl.dsp.global("caelestia:mediaToggle")'' { locked = true; })
      (bf ''shiftMod .. " + N"'' ''hl.dsp.global("caelestia:mediaNext")''   { locked = true; })
      (bf ''shiftMod .. " + B"'' ''hl.dsp.global("caelestia:mediaPrev")''   { locked = true; })
      (bf ''shiftMod .. " + P"'' ''hl.dsp.global("caelestia:mediaToggle")'' { locked = true; })

      # Brillo
      (bf ''"XF86MonBrightnessUp"''   ''hl.dsp.global("caelestia:brightnessUp")'   { locked = true; })
      (bf ''"XF86MonBrightnessDown"'' ''hl.dsp.global("caelestia:brightnessDown")'' { locked = true; })

      # Lock/suspend — doble dispatch con función Lua
      (bf ''mod .. " + L"''
          ''function()
            hl.dispatch(hl.dsp.exec_cmd("caelestia shell -d"))
            hl.dispatch(hl.dsp.global("caelestia:lock"))
          end''
          { locked = true; })
      (bf ''shiftMod .. " + Escape"'' ''hl.dsp.exec_cmd("systemctl suspend")'' { locked = true; })

      # Zoom (repeating)
      (bf ''mod .. " + minus"''
          ''hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 - 0.1}')")''
          { repeating = true; })
      (bf ''mod .. " + equal"''
          ''hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 + 0.1}')")''
          { repeating = true; })

      # Reload (release)
      (bf ''"CTRL + " .. mod .. " + R"''
          ''hl.dsp.exec_cmd("bash -c 'hyprctl reload; caelestia shell --kill; sleep .1; caelestia shell -d'")''
          { release = true; })
    ]
    # Workspaces 1-9: hl.dsp.focus({ workspace = N }) — confirmado en el código oficial
    ++ (lib.concatLists (lib.genList
      (i:
        let ws = i + 1; key = "code:1${toString i}"; in
        [
          (b  ''mod .. " + ${key}"''              ''hl.dsp.focus({ workspace = ${toString ws} })'')
          (b  ''shiftMod .. " + ${key}"''          ''hl.dsp.window.move({ workspace = ${toString ws} })'')
          (b  ''"ALT + " .. mod .. " + ${key}"''  ''hl.dsp.window.move({ workspace = ${toString ws}, silent = true })'')
        ])
      9));
}
