{ ... }:
let
  totalWorkspaces = 9;
in
{
  wayland.windowManager.hyprland.settings = {

    # --- ATANJOS ESTÁNDAR (bind) ---
    bind = [
      { mods = [ "SUPER" ]; key = "Q"; action = "killactive"; }
      { mods = [ "SUPER" ]; key = "F"; action = "fullscreen"; args = [ "0" ]; }
      { mods = [ "SUPER" ]; key = "D"; action = "fullscreen"; args = [ "1" ]; }
      { mods = [ "ALT" "SUPER" ]; key = "SPACE"; action = "togglefloating"; }
      { mods = [ "SUPER" ]; key = "P"; action = "pin"; }
      { mods = [ "ALT" ]; key = "F4"; action = "killactive"; }
      { mods = [ "ALT" ]; key = "TAB"; action = "workspace"; args = [ "previous" ]; }

      # Foco con flechas
      { mods = [ "SUPER" ]; key = "Left"; action = "movefocus"; args = [ "l" ]; }
      { mods = [ "SUPER" ]; key = "Right"; action = "movefocus"; args = [ "r" ]; }
      { mods = [ "SUPER" ]; key = "Up"; action = "movefocus"; args = [ "u" ]; }
      { mods = [ "SUPER" ]; key = "Down"; action = "movefocus"; args = [ "d" ]; }

      # Mover ventanas con flechas
      { mods = [ "SUPER_SHIFT" ]; key = "Left"; action = "movewindow"; args = [ "l" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "Right"; action = "movewindow"; args = [ "r" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "Up"; action = "movewindow"; args = [ "u" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "Down"; action = "movewindow"; args = [ "d" ]; }

      # Mover ventanas vim-style
      { mods = [ "SUPER_SHIFT" ]; key = "H"; action = "movewindow"; args = [ "l" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "L"; action = "movewindow"; args = [ "r" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "K"; action = "movewindow"; args = [ "u" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "J"; action = "movewindow"; args = [ "d" ]; }

      # Workspaces con flechas / mouse
      { mods = [ "CTRL" "SUPER" ]; key = "Right"; action = "workspace"; args = [ "r+1" ]; }
      { mods = [ "CTRL" "SUPER" ]; key = "Left"; action = "workspace"; args = [ "r-1" ]; }
      { mods = [ "SUPER" ]; key = "mouse_up"; action = "workspace"; args = [ "+1" ]; }
      { mods = [ "SUPER" ]; key = "mouse_down"; action = "workspace"; args = [ "-1" ]; }

      # Mover ventana a workspace con mouse
      { mods = [ "SUPER_SHIFT" ]; key = "mouse_down"; action = "movetoworkspace"; args = [ "r-1" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "mouse_up"; action = "movetoworkspace"; args = [ "r+1" ]; }

      # Scratchpad
      { mods = [ "SUPER" ]; key = "S"; action = "togglespecialworkspace"; }
      { mods = [ "SUPER" "ALT" ]; key = "S"; action = "movetoworkspacesilent"; args = [ "special" ]; }

      # Split ratio
      { mods = [ "SUPER" ]; key = "semicolon"; action = "layoutmsg"; args = [ "splitratio -0.1" ]; }
      { mods = [ "SUPER" ]; key = "apostrophe"; action = "layoutmsg"; args = [ "splitratio +0.1" ]; }

      # Apps (uwsm)
      { mods = [ "SUPER" ]; key = "Return"; action = "exec"; args = [ "uwsm app -- foot" ]; }
      { mods = [ "SUPER" ]; key = "T"; action = "exec"; args = [ "uwsm app -- foot" ]; }
      { mods = [ "CTRL" "ALT" ]; key = "T"; action = "exec"; args = [ "uwsm app -- foot" ]; }
      { mods = [ "SUPER" ]; key = "E"; action = "exec"; args = [ "uwsm app -- dolphin" ]; }
      { mods = [ "SUPER" ]; key = "W"; action = "exec"; args = [ "uwsm app -- zen-beta" ]; }
      { mods = [ "SUPER" ]; key = "C"; action = "exec"; args = [ "uwsm app -- zeditor" ]; }
      { mods = [ "CTRL" "SUPER" ]; key = "V"; action = "exec"; args = [ "uwsm app -- pavucontrol" ]; }
      
      # Caelestia shell
      { mods = [ "SUPER" ]; key = "N"; action = "exec"; args = [ "caelestia shell drawers toggle dashboard" ]; }
      { mods = [ "CTRL" "ALT" ]; key = "Delete"; action = "exec"; args = [ "caelestia shell drawers toggle session" ]; }
      { mods = [ "SUPER" ]; key = "K"; action = "exec"; args = [ "caelestia shell drawers toggle all" ]; }
      { mods = [ "CTRL" "ALT" ]; key = "C"; action = "exec"; args = [ "caelestia shell notifications clear" ]; }

      # Screenshot
      { mods = [ "SUPER_SHIFT" ]; key = "S"; action = "global"; args = [ "caelestia:screenshotFreeze" ]; }
      { mods = [ "SUPER" ]; key = "Print"; action = "global"; args = [ "caelestia:screenshot" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "Print"; action = "global"; args = [ "caelestia:screenshot" ]; }
      { mods = [ ]; key = "Print"; action = "exec"; args = [ "caelestia screenshot" ]; }

      # Color picker
      { mods = [ "SUPER_SHIFT" ]; key = "C"; action = "exec"; args = [ "hyprpicker -a" ]; }

      # Clipboard and emoji picker
      { mods = [ "SUPER" ]; key = "V"; action = "exec"; args = [ "pkill fuzzel || caelestia clipboard" ]; }
      { mods = [ "SUPER" ]; key = "Period"; action = "exec"; args = [ "pkill fuzzel || caelestia emoji -p" ]; }
    ] ++ (builtins.concatLists (builtins.genList (i:
      let ws = i + 1;
      in [
        { mods = [ "SUPER" ]; key = "code:1${toString i}"; action = "workspace"; args = [ (toString ws) ]; }
        { mods = [ "SUPER_SHIFT" ]; key = "code:1${toString i}"; action = "movetoworkspace"; args = [ (toString ws) ]; }
        { mods = [ "SUPER" "ALT" ]; key = "code:1${toString i}"; action = "movetoworkspacesilent"; args = [ (toString ws) ]; }
      ]) totalWorkspaces
    ));

    # --- CONTROLES DE MOUSE (bindm) ---
    bindm = [
      { mods = [ "SUPER" ]; key = "mouse:272"; action = "movewindow"; }
      { mods = [ "SUPER" ]; key = "mouse:274"; action = "movewindow"; }
      { mods = [ "SUPER" ]; key = "mouse:273"; action = "resizewindow"; }
    ];

    # --- REPETICIÓN CON EVENTOS DE BLOQUEO (bindel) ---
    bindel = [
      # Volumen
      { mods = [ ]; key = "XF86AudioRaiseVolume"; action = "exec"; args = [ "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+" ]; }
      { mods = [ ]; key = "XF86AudioLowerVolume"; action = "exec"; args = [ "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-" ]; }
    ];

    # --- EVENTOS DE BLOQUEO PURO (bindl) ---
    bindl = [
      # Audio
      { mods = [ ]; key = "XF86AudioMute"; action = "exec"; args = [ "wpctl set-mute @DEFAULT_SINK@ toggle" ]; }
      { mods = [ ]; key = "XF86AudioMicMute"; action = "exec"; args = [ "wpctl set-mute @DEFAULT_SOURCE@ toggle" ]; }
      { mods = [ "ALT" ]; key = "XF86AudioMute"; action = "exec"; args = [ "wpctl set-mute @DEFAULT_SOURCE@ toggle" ]; }
      
      # Media Player
      { mods = [ ]; key = "XF86AudioNext"; action = "global"; args = [ "caelestia:mediaNext" ]; }
      { mods = [ ]; key = "XF86AudioPrev"; action = "global"; args = [ "caelestia:mediaPrev" ]; }
      { mods = [ ]; key = "XF86AudioPlay"; action = "global"; args = [ "caelestia:mediaToggle" ]; }
      { mods = [ ]; key = "XF86AudioPause"; action = "global"; args = [ "caelestia:mediaToggle" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "N"; action = "global"; args = [ "caelestia:mediaNext" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "B"; action = "global"; args = [ "caelestia:mediaPrev" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "P"; action = "global"; args = [ "caelestia:mediaToggle" ]; }
      
      # Brillo (Caelestia global)
      { mods = [ ]; key = "XF86MonBrightnessUp"; action = "global"; args = [ "caelestia:brightnessUp" ]; }
      { mods = [ ]; key = "XF86MonBrightnessDown"; action = "global"; args = [ "caelestia:brightnessDown" ]; }

      # Lock / Suspend
      { mods = [ "SUPER" ]; key = "L"; action = "exec"; args = [ "caelestia shell -d" ]; }
      { mods = [ "SUPER" ]; key = "L"; action = "global"; args = [ "caelestia:lock" ]; }
      { mods = [ "SUPER_SHIFT" ]; key = "Escape"; action = "exec"; args = [ "systemctl suspend" ]; }
    ];

    # --- REPETICIÓN NORMAL (binde) ---
    binde = [
      # Zoom del cursor
      { mods = [ "SUPER" ]; key = "minus"; action = "exec"; args = [ "hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 - 0.1}')" ]; }
      { mods = [ "SUPER" ]; key = "equal"; action = "exec"; args = [ "hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 + 0.1}')" ]; }
    ];

    # --- EVENTOS AL SOLTAR LA TECLA (bindr) ---
    bindr = [
      # Reiniciar Caelestia Shell
      { mods = [ "CTRL" "SUPER" ]; key = "R"; action = "exec"; args = [ "bash -c 'hyprctl reload; caelestia shell --kill; sleep .1; caelestia shell -d'" ]; }
    ];
  };
}
