{ ... }:
let
  totalWorkspaces = 9;
in
{
  wayland.windowManager.hyprland = {
    # IMPORTANTE: Vaciamos las listas de settings para que Home Manager no genere esas tablas rotas
    settings = {
      bind = [];
      bindm = [];
      bindel = [];
      bindl = [];
      binde = [];
      bindr = [];
    };

    # Metemos todos los binds formateados en Lua nativo dentro de extraConfig
    extraConfig = ''
      -- --- ATADOS ESTÁNDAR (bind) ---
      hl.bind("SUPER, Q", "killactive")
      hl.bind("SUPER, F", "fullscreen", "0")
      hl.bind("SUPER, D", "fullscreen", "1")
      hl.bind("ALT SUPER, SPACE", "togglefloating")
      hl.bind("SUPER, P", "pin")
      hl.bind("ALT, F4", "killactive")
      hl.bind("ALT, TAB", "workspace", "previous")

      -- Foco con flechas
      hl.bind("SUPER, Left", "movefocus", "l")
      hl.bind("SUPER, Right", "movefocus", "r")
      hl.bind("SUPER, Up", "movefocus", "u")
      hl.bind("SUPER, Down", "movefocus", "d")

      -- Mover ventanas con flechas
      hl.bind("SUPER_SHIFT, Left", "movewindow", "l")
      hl.bind("SUPER_SHIFT, Right", "movewindow", "r")
      hl.bind("SUPER_SHIFT, Up", "movewindow", "u")
      hl.bind("SUPER_SHIFT, Down", "movewindow", "d")

      -- Mover ventanas vim-style
      hl.bind("SUPER_SHIFT, H", "movewindow", "l")
      hl.bind("SUPER_SHIFT, L", "movewindow", "r")
      hl.bind("SUPER_SHIFT, K", "movewindow", "u")
      hl.bind("SUPER_SHIFT, J", "movewindow", "d")

      -- Workspaces con flechas / mouse
      hl.bind("CTRL SUPER, Right", "workspace", "r+1")
      hl.bind("CTRL SUPER, Left", "workspace", "r-1")
      hl.bind("SUPER, mouse_up", "workspace", "+1")
      hl.bind("SUPER, mouse_down", "workspace", "-1")

      -- Mover ventana a workspace con mouse
      hl.bind("SUPER_SHIFT, mouse_down", "movetoworkspace", "r-1")
      hl.bind("SUPER_SHIFT, mouse_up", "movetoworkspace", "r+1")

      -- Scratchpad
      hl.bind("SUPER, S", "togglespecialworkspace")
      hl.bind("SUPER ALT, S", "movetoworkspacesilent", "special")

      -- Split ratio
      hl.bind("SUPER, semicolon", "layoutmsg", "splitratio -0.1")
      hl.bind("SUPER, apostrophe", "layoutmsg", "splitratio +0.1")

      -- Apps (uwsm)
      hl.bind("SUPER, Return", "exec", "uwsm app -- foot")
      hl.bind("SUPER, T", "exec", "uwsm app -- foot")
      hl.bind("CTRL ALT, T", "exec", "uwsm app -- foot")
      hl.bind("SUPER, E", "exec", "uwsm app -- dolphin")
      hl.bind("SUPER, W", "exec", "uwsm app -- zen-beta")
      hl.bind("SUPER, C", "exec", "uwsm app -- zeditor")
      hl.bind("CTRL SUPER, V", "exec", "uwsm app -- pavucontrol")
      
      -- Caelestia shell
      hl.bind("SUPER, N", "exec", "caelestia shell drawers toggle dashboard")
      hl.bind("CTRL ALT, Delete", "exec", "caelestia shell drawers toggle session")
      hl.bind("SUPER, K", "exec", "caelestia shell drawers toggle all")
      hl.bind("CTRL ALT, C", "exec", "caelestia shell notifications clear")

      -- Screenshot
      hl.bind("SUPER_SHIFT, S", "global", "caelestia:screenshotFreeze")
      hl.bind("SUPER, Print", "global", "caelestia:screenshot")
      hl.bind("SUPER_SHIFT, Print", "global", "caelestia:screenshot")
      hl.bind(", Print", "exec", "caelestia screenshot")

      -- Color picker
      hl.bind("SUPER_SHIFT, C", "exec", "hyprpicker -a")

      -- Clipboard and emoji picker
      hl.bind("SUPER, V", "exec", "pkill fuzzel || caelestia clipboard")
      hl.bind("SUPER, Period", "exec", "pkill fuzzel || caelestia emoji -p")

      -- Generación dinámica de Workspaces en Lua puro
      for i = 0, ${toString (totalWorkspaces - 1)} do
        local ws = i + 1
        hl.bind("SUPER, code:1" .. i, "workspace", tostring(ws))
        hl.bind("SUPER_SHIFT, code:1" .. i, "movetoworkspace", tostring(ws))
        hl.bind("SUPER ALT, code:1" .. i, "movetoworkspacesilent", tostring(ws))
      end

      -- --- CONTROLES DE MOUSE (bindm) ---
      hl.bindm("SUPER, mouse:272", "movewindow")
      hl.bindm("SUPER, mouse:274", "movewindow")
      hl.bindm("SUPER, mouse:273", "resizewindow")

      -- --- REPETICIÓN CON EVENTOS DE BLOQUEO (bindel) ---
      hl.bindel(", XF86AudioRaiseVolume", "exec", "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+")
      hl.bindel(", XF86AudioLowerVolume", "exec", "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-")

      -- --- EVENTOS DE BLOQUEO PURO (bindl) ---
      hl.bindl(", XF86AudioMute", "exec", "wpctl set-mute @DEFAULT_SINK@ toggle")
      hl.bindl(", XF86AudioMicMute", "exec", "wpctl set-mute @DEFAULT_SOURCE@ toggle")
      hl.bindl("ALT, XF86AudioMute", "exec", "wpctl set-mute @DEFAULT_SOURCE@ toggle")
      hl.bindl(", XF86AudioNext", "global", "caelestia:mediaNext")
      hl.bindl(", XF86AudioPrev", "global", "caelestia:mediaPrev")
      hl.bindl(", XF86AudioPlay", "global", "caelestia:mediaToggle")
      hl.bindl(", XF86AudioPause", "global", "caelestia:mediaToggle")
      hl.bindl("SUPER_SHIFT, N", "global", "caelestia:mediaNext")
      hl.bindl("SUPER_SHIFT, B", "global", "caelestia:mediaPrev")
      hl.bindl("SUPER_SHIFT, P", "global", "caelestia:mediaToggle")
      hl.bindl(", XF86MonBrightnessUp", "global", "caelestia:brightnessUp")
      hl.bindl(", XF86MonBrightnessDown", "global", "caelestia:brightnessDown")
      hl.bindl("SUPER, L", "exec", "caelestia shell -d")
      hl.bindl("SUPER, L", "global", "caelestia:lock")
      hl.bindl("SUPER_SHIFT, Escape", "exec", "systemctl suspend")

      -- --- REPETICIÓN NORMAL (binde) ---
      hl.binde("SUPER, minus", "exec", "hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 - 0.1}')")
      hl.binde("SUPER, equal", "exec", "hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 + 0.1}')")

      -- --- EVENTOS AL SOLTAR LA TECLA (bindr) ---
      hl.bindr("CTRL SUPER, R", "exec", "bash -c 'hyprctl reload; caelestia shell --kill; sleep .1; caelestia shell -d'")
    '';
  };
}
