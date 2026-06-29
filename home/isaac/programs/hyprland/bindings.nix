{ lib, ... }:
let
  inline = lib.generators.mkLuaInline;
  totalWorkspaces = 9;

  # key: expresión Lua para la combinación de teclas
  # dispatcher: expresión Lua del dispatcher (o función completa)
  # flags: tabla Nix opcional de flags de hl.bind (locked, repeating, release, mouse, ignore_mods, non_consuming...)
  mkBind = { key, dispatcher, flags ? null }:
    {
      _args = [ (inline key) (inline dispatcher) ] ++ lib.optional (flags != null) flags;
    };
in
{
  wayland.windowManager.hyprland.settings = {
    bind =
      [
        (mkBind { key = ''mod .. " + Q"'';      dispatcher = "hl.dsp.window.close()"; })
        (mkBind { key = ''mod .. " + F"'';      dispatcher = ''hl.dsp.window.fullscreen({ mode = "maximized" })''; })  # fullscreen, 0
        (mkBind { key = ''mod .. " + D"'';      dispatcher = ''hl.dsp.window.fullscreen({ mode = "fullscreen" })''; }) # fullscreen, 1
        (mkBind { key = ''"ALT + " .. mod .. " + SPACE"''; dispatcher = ''hl.dsp.window.float({ action = "toggle" })''; })
        (mkBind { key = ''mod .. " + P"'';      dispatcher = "hl.dsp.window.pin()"; })
        (mkBind { key = ''"ALT + F4"'';         dispatcher = "hl.dsp.window.close()"; })
        (mkBind { key = ''"ALT + TAB"'';        dispatcher = ''hl.dsp.workspace.change({ workspace = "previous" })''; })

        # Foco con flechas
        (mkBind { key = ''mod .. " + Left"'';   dispatcher = ''hl.dsp.focus({ direction = "l" })''; })
        (mkBind { key = ''mod .. " + Right"'';  dispatcher = ''hl.dsp.focus({ direction = "r" })''; })
        (mkBind { key = ''mod .. " + Up"'';     dispatcher = ''hl.dsp.focus({ direction = "u" })''; })
        (mkBind { key = ''mod .. " + Down"'';   dispatcher = ''hl.dsp.focus({ direction = "d" })''; })

        # Mover ventanas con flechas
        (mkBind { key = ''shiftMod .. " + Left"'';  dispatcher = ''hl.dsp.window.move({ direction = "l" })''; })
        (mkBind { key = ''shiftMod .. " + Right"''; dispatcher = ''hl.dsp.window.move({ direction = "r" })''; })
        (mkBind { key = ''shiftMod .. " + Up"'';    dispatcher = ''hl.dsp.window.move({ direction = "u" })''; })
        (mkBind { key = ''shiftMod .. " + Down"'';  dispatcher = ''hl.dsp.window.move({ direction = "d" })''; })

        # Mover ventanas vim-style
        (mkBind { key = ''shiftMod .. " + H"''; dispatcher = ''hl.dsp.window.move({ direction = "l" })''; })
        (mkBind { key = ''shiftMod .. " + L"''; dispatcher = ''hl.dsp.window.move({ direction = "r" })''; })
        (mkBind { key = ''shiftMod .. " + K"''; dispatcher = ''hl.dsp.window.move({ direction = "u" })''; })
        (mkBind { key = ''shiftMod .. " + J"''; dispatcher = ''hl.dsp.window.move({ direction = "d" })''; })

        # Workspaces con flechas
        (mkBind { key = ''"CTRL + " .. mod .. " + Right"''; dispatcher = ''hl.dsp.workspace.change({ workspace = "r+1" })''; })
        (mkBind { key = ''"CTRL + " .. mod .. " + Left"'';  dispatcher = ''hl.dsp.workspace.change({ workspace = "r-1" })''; })
        (mkBind { key = ''mod .. " + mouse_up"'';   dispatcher = ''hl.dsp.workspace.change({ workspace = "+1" })''; })
        (mkBind { key = ''mod .. " + mouse_down"''; dispatcher = ''hl.dsp.workspace.change({ workspace = "-1" })''; })

        # Mover ventana a workspace con scroll
        (mkBind { key = ''shiftMod .. " + mouse_down"''; dispatcher = ''hl.dsp.window.move({ workspace = "r-1" })''; })
        (mkBind { key = ''shiftMod .. " + mouse_up"'';   dispatcher = ''hl.dsp.window.move({ workspace = "r+1" })''; })

        # Scratchpad
        (mkBind { key = ''mod .. " + S"'';          dispatcher = "hl.dsp.workspace.toggle_special()"; })
        (mkBind { key = ''"ALT + " .. mod .. " + S"''; dispatcher = ''hl.dsp.window.move({ workspace = "special", silent = true })''; })

        # Split ratio
        (mkBind { key = ''mod .. " + semicolon"'';  dispatcher = ''hl.dsp.layout("splitratio -0.1")''; })
        (mkBind { key = ''mod .. " + apostrophe"''; dispatcher = ''hl.dsp.layout("splitratio +0.1")''; })

        # Apps
        (mkBind { key = ''mod .. " + Return"'';        dispatcher = ''hl.dsp.exec_cmd("uwsm app -- foot")''; })
        (mkBind { key = ''mod .. " + T"'';             dispatcher = ''hl.dsp.exec_cmd("uwsm app -- foot")''; })
        (mkBind { key = ''"CTRL + ALT + T"'';          dispatcher = ''hl.dsp.exec_cmd("uwsm app -- foot")''; })
        (mkBind { key = ''mod .. " + E"'';             dispatcher = ''hl.dsp.exec_cmd("uwsm app -- dolphin")''; })
        (mkBind { key = ''mod .. " + W"'';             dispatcher = ''hl.dsp.exec_cmd("uwsm app -- zen-beta")''; })
        (mkBind { key = ''mod .. " + C"'';             dispatcher = ''hl.dsp.exec_cmd("uwsm app -- zeditor")''; })
        (mkBind { key = ''"CTRL + " .. mod .. " + V"''; dispatcher = ''hl.dsp.exec_cmd("uwsm app -- pavucontrol")''; })

        # Caelestia shell
        (mkBind { key = ''mod .. " + N"'';             dispatcher = ''hl.dsp.exec_cmd("caelestia shell drawers toggle dashboard")''; })
        (mkBind { key = ''"CTRL + ALT + Delete"'';     dispatcher = ''hl.dsp.exec_cmd("caelestia shell drawers toggle session")''; })
        (mkBind { key = ''mod .. " + K"'';             dispatcher = ''hl.dsp.exec_cmd("caelestia shell drawers toggle all")''; })
        (mkBind { key = ''"CTRL + ALT + C"'';          dispatcher = ''hl.dsp.exec_cmd("caelestia shell notifications clear")''; })

        # Screenshot (global, vía XDPH)
        (mkBind { key = ''shiftMod .. " + S"'';      dispatcher = ''hl.dsp.global("caelestia:screenshotFreeze")''; })
        (mkBind { key = ''mod .. " + Print"'';       dispatcher = ''hl.dsp.global("caelestia:screenshot")''; })
        (mkBind { key = ''shiftMod .. " + Print"'';  dispatcher = ''hl.dsp.global("caelestia:screenshot")''; })
        (mkBind { key = ''"Print"'';                 dispatcher = ''hl.dsp.exec_cmd("caelestia screenshot")''; })

        # Color picker
        (mkBind { key = ''shiftMod .. " + C"''; dispatcher = ''hl.dsp.exec_cmd("hyprpicker -a")''; })

        # Clipboard y emoji picker
        (mkBind { key = ''mod .. " + V"'';      dispatcher = ''hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard")''; })
        (mkBind { key = ''mod .. " + Period"''; dispatcher = ''hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p")''; })

        # ---------------------------------------------------
        # Binds de ratón (antiguo bindm) -> bind normal + flag mouse
        # ---------------------------------------------------
        (mkBind { key = ''mod .. " + mouse:272"''; dispatcher = "hl.dsp.window.drag()"; flags = { mouse = true; }; })
        (mkBind { key = ''mod .. " + mouse:274"''; dispatcher = "hl.dsp.window.drag()"; flags = { mouse = true; }; })
        (mkBind { key = ''mod .. " + mouse:273"''; dispatcher = "hl.dsp.window.resize()"; flags = { mouse = true; }; })

        # ---------------------------------------------------
        # bindel: repeating + locked (volumen)
        # ---------------------------------------------------
        (mkBind {
          key = ''"XF86AudioRaiseVolume"'';
          dispatcher = ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+")'';
          flags = { repeating = true; locked = true; };
        })
        (mkBind {
          key = ''"XF86AudioLowerVolume"'';
          dispatcher = ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-")'';
          flags = { repeating = true; locked = true; };
        })

        # ---------------------------------------------------
        # bindl: locked (funcionan con sesión bloqueada)
        # ---------------------------------------------------
        (mkBind { key = ''"XF86AudioMute"''; dispatcher = ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle")''; flags = { locked = true; }; })
        (mkBind { key = ''"XF86AudioMicMute"''; dispatcher = ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle")''; flags = { locked = true; }; })
        (mkBind { key = ''"ALT + XF86AudioMute"''; dispatcher = ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle")''; flags = { locked = true; }; })

        # Player
        (mkBind { key = ''"XF86AudioNext"''; dispatcher = ''hl.dsp.global("caelestia:mediaNext")''; flags = { locked = true; }; })
        (mkBind { key = ''"XF86AudioPrev"''; dispatcher = ''hl.dsp.global("caelestia:mediaPrev")''; flags = { locked = true; }; })
        (mkBind { key = ''"XF86AudioPlay"''; dispatcher = ''hl.dsp.global("caelestia:mediaToggle")''; flags = { locked = true; }; })
        (mkBind { key = ''"XF86AudioPause"''; dispatcher = ''hl.dsp.global("caelestia:mediaToggle")''; flags = { locked = true; }; })
        (mkBind { key = ''shiftMod .. " + N"''; dispatcher = ''hl.dsp.global("caelestia:mediaNext")''; flags = { locked = true; }; })
        (mkBind { key = ''shiftMod .. " + B"''; dispatcher = ''hl.dsp.global("caelestia:mediaPrev")''; flags = { locked = true; }; })
        (mkBind { key = ''shiftMod .. " + P"''; dispatcher = ''hl.dsp.global("caelestia:mediaToggle")''; flags = { locked = true; }; })

        # Brightness
        (mkBind { key = ''"XF86MonBrightnessUp"''; dispatcher = ''hl.dsp.global("caelestia:brightnessUp")''; flags = { locked = true; }; })
        (mkBind { key = ''"XF86MonBrightnessDown"''; dispatcher = ''hl.dsp.global("caelestia:brightnessDown")''; flags = { locked = true; }; })

        # Lock / suspend (dos dispatchers en un mismo bind -> función lua)
        (mkBind {
          key = ''mod .. " + L"'';
          dispatcher = ''
            function()
              hl.dispatch(hl.dsp.exec_cmd("caelestia shell -d"))
              hl.dispatch(hl.dsp.global("caelestia:lock"))
            end
          '';
          flags = { locked = true; };
        })
        (mkBind { key = ''shiftMod .. " + Escape"''; dispatcher = ''hl.dsp.exec_cmd("systemctl suspend")''; flags = { locked = true; }; })

        # ---------------------------------------------------
        # binde: repeating (zoom)
        # ---------------------------------------------------
        (mkBind {
          key = ''mod .. " + minus"'';
          dispatcher = ''hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 - 0.1}')")'';
          flags = { repeating = true; };
        })
        (mkBind {
          key = ''mod .. " + equal"'';
          dispatcher = ''hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 + 0.1}')")'';
          flags = { repeating = true; };
        })

        # ---------------------------------------------------
        # bindr: release (se dispara al soltar la tecla)
        # ---------------------------------------------------
        (mkBind {
          key = ''"CTRL + " .. mod .. " + R"'';
          dispatcher = ''hl.dsp.exec_cmd("bash -c 'hyprctl reload; caelestia shell --kill; sleep .1; caelestia shell -d'")'';
          flags = { release = true; };
        })
      ]
      # Workspaces 1-9 (code:10 .. code:19, igual que el original)
      ++ (lib.concatLists (lib.genList
        (i:
          let
            ws = i + 1;
            key = "code:1${toString i}";
          in
          [
            (mkBind { key = ''mod .. " + ${key}"'';            dispatcher = "hl.dsp.workspace.change({ workspace = ${toString ws} })"; })
            (mkBind { key = ''shiftMod .. " + ${key}"'';        dispatcher = "hl.dsp.window.move({ workspace = ${toString ws} })"; })
            (mkBind { key = ''"ALT + " .. mod .. " + ${key}"''; dispatcher = "hl.dsp.window.move({ workspace = ${toString ws}, silent = true })"; })
          ])
        totalWorkspaces));
  };
}
