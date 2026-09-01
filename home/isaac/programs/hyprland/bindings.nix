{ lib, ... }:
let
  inline = lib.generators.mkLuaInline;

  # Helper para binds simples
  b = key: dispatcher: {
    _args = [ (inline key) (inline dispatcher) ];
  };

  # Helper para binds con flags (release, locked, repeating, mouse)
  bf = key: dispatcher: flags: {
    _args = [ (inline key) (inline dispatcher) flags ];
  };
in
{
  wayland.windowManager.hyprland.settings.bind =
    [
      # Launcher de Caelestia — bind directo con release = true
      (bf ''"SUPER + SUPER_L"'' ''hl.dsp.global("caelestia:launcher")'' { release = true; })

      # Ventanas
      (b  ''mod .. " + Q"''                  ''hl.dsp.window.close()'')
      (b  ''mod .. " + F"''                  ''hl.dsp.window.fullscreen({ mode = "maximized" })'')
      (b  ''mod .. " + D"''                  ''hl.dsp.window.fullscreen({ mode = "fullscreen" })'')
      (b  ''"ALT + " .. mod .. " + SPACE"''  ''hl.dsp.window.float()'')
      (b  ''mod .. " + P"''                  ''hl.dsp.window.pin()'')
      (b  ''"ALT + F4"''                     ''hl.dsp.window.close()'')

      # Workspaces (Navegación)
      (b  ''"ALT + TAB"''                    ''hl.dsp.focus({ workspace = "previous" })'')
      (bf ''"CTRL + " .. mod .. " + Right"'' ''hl.dsp.focus({ workspace = "+1" })'' { repeating = true; })
      (bf ''"CTRL + " .. mod .. " + Left"''  ''hl.dsp.focus({ workspace = "-1" })'' { repeating = true; })
      (b  ''mod .. " + mouse_up"''           ''hl.dsp.focus({ workspace = "+1" })'')
      (b  ''mod .. " + mouse_down"''         ''hl.dsp.focus({ workspace = "-1" })'')

      # Mover ventana a workspace con scroll
      (b  ''shiftMod .. " + mouse_down"''    ''hl.dsp.window.move({ workspace = "-1" })'')
      (b  ''shiftMod .. " + mouse_up"''      ''hl.dsp.window.move({ workspace = "+1" })'')

      # Foco direccional
      (b  ''mod .. " + Left"''               ''hl.dsp.focus({ direction = "left" })'')
      (b  ''mod .. " + Right"''              ''hl.dsp.focus({ direction = "right" })'')
      (b  ''mod .. " + Up"''                 ''hl.dsp.focus({ direction = "up" })'')
      (b  ''mod .. " + Down"''               ''hl.dsp.focus({ direction = "down" })'')

      # Mover ventanas
      (b  ''shiftMod .. " + Left"''          ''hl.dsp.window.move({ direction = "left" })'')
      (b  ''shiftMod .. " + Right"''         ''hl.dsp.window.move({ direction = "right" })'')
      (b  ''shiftMod .. " + Up"''            ''hl.dsp.window.move({ direction = "up" })'')
      (b  ''shiftMod .. " + Down"''          ''hl.dsp.window.move({ direction = "down" })'')
      (b  ''shiftMod .. " + H"''             ''hl.dsp.window.move({ direction = "left" })'')
      (b  ''shiftMod .. " + L"''             ''hl.dsp.window.move({ direction = "right" })'')
      (b  ''shiftMod .. " + K"''             ''hl.dsp.window.move({ direction = "up" })'')
      (b  ''shiftMod .. " + J"''             ''hl.dsp.window.move({ direction = "down" })'')

      # Scratchpad / special workspace
      (b  ''mod .. " + S"''                  ''hl.dsp.window.move({ workspace = "special:special" })'')
      (b  ''"ALT + " .. mod .. " + S"''      ''hl.dsp.window.move({ workspace = "e+0" })'')

      # Master layout / resizing
      (b  ''mod .. " + semicolon"''          ''hl.dsp.layout("splitratio -0.1")'')
      (b  ''mod .. " + apostrophe"''         ''hl.dsp.layout("splitratio +0.1")'')

      # Apps
      (b  ''mod .. " + Return"''             ''hl.dsp.exec_cmd("uwsm app -- foot")'')
      (b  ''mod .. " + T"''                  ''hl.dsp.exec_cmd("uwsm app -- foot")'')
      (b  ''"CTRL + ALT + T"''               ''hl.dsp.exec_cmd("uwsm app -- foot")'')
      (b  ''mod .. " + E"''                  ''hl.dsp.exec_cmd("uwsm app -- dolphin")'')
      (b  ''mod .. " + W"''                  ''hl.dsp.exec_cmd("uwsm app -- zen-beta")'')
      (b  ''mod .. " + C"''                  ''hl.dsp.exec_cmd("uwsm app -- zeditor")'')
      (b  ''"CTRL + " .. mod .. " + V"''     ''hl.dsp.exec_cmd("uwsm app -- pavucontrol")'')

      # Caelestia UI Binds
      (b  ''mod .. " + N"''                  ''hl.dsp.global("caelestia:sidebar")'')
      (b  ''"CTRL + ALT + Delete"''          ''hl.dsp.global("caelestia:session")'')
      (b  ''mod .. " + K"''                  ''hl.dsp.global("caelestia:showall")'')
      (bf ''"CTRL + ALT + C"''               ''hl.dsp.global("caelestia:clearNotifs")'' { locked = true; })

      # Screenshot & Record
      (bf ''shiftMod .. " + S"''             ''hl.dsp.global("caelestia:screenshotFreeze")'' { locked = true; })
      (bf ''mod .. " + Print"''              ''hl.dsp.global("caelestia:screenshot")'' { locked = true; })
      (bf ''shiftMod .. " + Print"''         ''hl.dsp.global("caelestia:screenshot")'' { locked = true; })
      (bf ''"Print"''                        ''hl.dsp.exec_cmd("caelestia screenshot")'' { locked = true; })

      # Utilidades
      (b  ''shiftMod .. " + C"''             ''hl.dsp.exec_cmd("hyprpicker -a")'')
      (b  ''mod .. " + V"''                  ''hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard")'')
      (b  ''mod .. " + Period"''             ''hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p")'')

      # Mouse Binds (Arrastrar y redimensionar corrigiendo el comportamiento sostenido)
      (bf ''"SUPER + mouse:272"''            ''hl.dsp.window.drag()''   { mouse = true; })
      (bf ''"SUPER + mouse:274"''            ''hl.dsp.window.drag()''   { mouse = true; })
      (bf ''"SUPER + mouse:273"''            ''hl.dsp.window.resize()'' { mouse = true; })

      # Volumen (repeating + locked)
      (bf ''"XF86AudioRaiseVolume"''
          ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+")''
          { locked = true; repeating = true; })
      (bf ''"XF86AudioLowerVolume"''
          ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-")''
          { locked = true; repeating = true; })

      # Audio Mute (locked)
      (bf ''"XF86AudioMute"''                ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")''   { locked = true; })
      (bf ''"XF86AudioMicMute"''             ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")'' { locked = true; })

      # Media player
      (bf ''"XF86AudioNext"''                ''hl.dsp.global("caelestia:mediaNext")'' { locked = true; })
      (bf ''"XF86AudioPrev"''                ''hl.dsp.global("caelestia:mediaPrev")'' { locked = true; })
      (bf ''"XF86AudioPlay"''                ''hl.dsp.global("caelestia:mediaToggle")'' { locked = true; })
      (bf ''"XF86AudioPause"''               ''hl.dsp.global("caelestia:mediaToggle")'' { locked = true; })
      (bf ''shiftMod .. " + N"''             ''hl.dsp.global("caelestia:mediaNext")'' { locked = true; })
      (bf ''shiftMod .. " + B"''             ''hl.dsp.global("caelestia:mediaPrev")'' { locked = true; })
      (bf ''shiftMod .. " + P"''             ''hl.dsp.global("caelestia:mediaToggle")'' { locked = true; })

      # Brillo
      (bf ''"XF86MonBrightnessUp"''          ''hl.dsp.global("caelestia:brightnessUp")'' { locked = true; })
      (bf ''"XF86MonBrightnessDown"''        ''hl.dsp.global("caelestia:brightnessDown")'' { locked = true; })

      # Lock / Suspend
      {
        _args = [
          (inline ''mod .. " + L"'')
          (inline ''
            function()
              hl.dispatch(hl.dsp.exec_cmd("caelestia shell -d"))
              hl.dispatch(hl.dsp.global("caelestia:lock"))
            end
          '')
          { locked = true; }
        ];
      }
      (bf ''shiftMod .. " + Escape"''        ''hl.dsp.exec_cmd("systemctl suspend")'' { locked = true; })

      # Zoom (repeating)
      (bf ''mod .. " + minus"''
          ''hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 - 0.1}')")''
          { repeating = true; })
      (bf ''mod .. " + equal"''
          ''hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 + 0.1}')")''
          { repeating = true; })

      # Reload (release)
      (bf ''"CTRL + " .. mod .. " + SHIFT + R"'' ''hl.dsp.exec_cmd("qs -c caelestia kill")'' { release = true; })
      (bf ''"CTRL + " .. mod .. " + ALT + R"''   ''hl.dsp.exec_cmd("qs -c caelestia kill; sleep .1; caelestia shell -d")'' { release = true; })
    ]

    # Generación de Workspaces 1-9
    # mod + [1-9] -> ir al workspace
    # shiftMod + [1-9] -> mover ventana y seguirla
    # ALT + mod + [1-9] -> mover ventana sin cambiar de foco/escritorio (follow = false)
    ++ (lib.concatLists (lib.genList
      (i:
        let
          ws  = i + 1;
          key = "code:1${toString i}";
        in
        [
          (b  ''mod .. " + ${key}"''         ''hl.dsp.focus({ workspace = ${toString ws} })'')
          (b  ''shiftMod .. " + ${key}"''    ''hl.dsp.window.move({ workspace = ${toString ws} })'')
          (b  ''"ALT + " .. mod .. " + ${key}"'' ''hl.dsp.window.move({ workspace = ${toString ws}, follow = false })'')
        ])
      9));
}