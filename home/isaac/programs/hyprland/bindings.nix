{ ... }:
let
  totalWorkspaces = 9;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod, Q, killactive"
      "$mod, F, fullscreen, 0"
      "$mod, D, fullscreen, 1"           # Maximize
      "ALT $mod, SPACE, togglefloating"
      "$mod, P, pin"
      "ALT, F4, killactive"
      "ALT, TAB, workspace, previous"

      # Foco con flechas
      "$mod, Left,  movefocus, l"
      "$mod, Right, movefocus, r"
      "$mod, Up,    movefocus, u"
      "$mod, Down,  movefocus, d"

      # Foco vim-style
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"

      # Mover ventanas con flechas
      "$shiftMod, Left,  movewindow, l"
      "$shiftMod, Right, movewindow, r"
      "$shiftMod, Up,    movewindow, u"
      "$shiftMod, Down,  movewindow, d"

      # Mover ventanas vim-style
      "$shiftMod, H, movewindow, l"
      "$shiftMod, L, movewindow, r"
      "$shiftMod, K, movewindow, u"
      "$shiftMod, J, movewindow, d"

      # Workspaces con flechas
      "CTRL $mod, Right, workspace, r+1"
      "CTRL $mod, Left,  workspace, r-1"
      "$mod, mouse_up,   workspace, +1"
      "$mod, mouse_down, workspace, -1"

      # Mover ventana a workspace
      "$shiftMod, mouse_down, movetoworkspace, r-1"
      "$shiftMod, mouse_up,   movetoworkspace, r+1"

      # Scratchpad
      "$mod, S, togglespecialworkspace"
      "$mod ALT, S, movetoworkspacesilent, special"

      # Split ratio
      "$mod, semicolon,  layoutmsg, splitratio -0.1"
      "$mod, apostrophe, layoutmsg, splitratio +0.1"

      # Apps
      "$mod, Return, exec, uwsm app -- kitty"
      "$mod, T,      exec, uwsm app -- kitty"
      "CTRL ALT, T,  exec, uwsm app -- kitty"
      "$mod, E,      exec, uwsm app -- dolphin"
      "$mod, W,      exec, uwsm app -- firefox"
      "$mod, C,      exec, uwsm app -- code"
      "CTRL $mod, V, exec, uwsm app -- pavucontrol"

      # Caelestia shell
      "$mod, N,        exec, caelestia shell drawers toggle dashboard"
      "CTRL ALT, Delete, exec, caelestia shell drawers toggle session"
      "$mod, K, exec, caelestia shell drawers toggle all"
      "CTRL ALT, C, exec, caelestia shell notifications clear"

      # Screenshot
      "$shiftMod, S,     exec, hyprshot --freeze --clipboard-only --mode region --silent"
      "$mod, Print,      exec, hyprshot -m region"
      "$shiftMod, Print, exec, hyprshot -m output"
      ", Print,          exec, hyprshot -m output --clipboard-only"

      # Color picker
      "$shiftMod, C, exec, hyprpicker -a"

      # Lock / suspend
      "$mod, Escape, exec, loginctl lock-session"
      "$mod, L, exec, loginctl lock-session"
      "$shiftMod, Escape, exec, systemctl suspend"

      # Restart caelestia shell
      "CTRL $mod, R, exec, bash -c 'hyprctl reload; systemctl --user stop $(systemctl --user list-units --no-legend | grep caelestia | awk \"{print $1}\"); sleep 1; uwsm app -- caelestia shell'"
    ] ++ (builtins.concatLists (builtins.genList (i:
      let ws = i + 1;
      in [
        "$mod,      code:1${toString i}, workspace,       ${toString ws}"
        "$shiftMod, code:1${toString i}, movetoworkspace,  ${toString ws}"
        "$mod ALT,  code:1${toString i}, movetoworkspacesilent, ${toString ws}"
      ]) totalWorkspaces
    ));

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:274, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindel = [
      # Brillo
      ",XF86MonBrightnessUp,   exec, brightnessctl set +5%"
      ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      # Volumen
      ",XF86AudioRaiseVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.5"
      ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
    ];

    bindl = [
      # Caelestia
      "SUPER, SUPER_L, exec, caelestia shell drawers toggle launcher"
      ",XF86AudioMute,    exec, wpctl set-mute @DEFAULT_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      "ALT,XF86AudioMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      ",XF86AudioNext,  exec, playerctl next"
      ",XF86AudioPrev,  exec, playerctl previous"
      ",XF86AudioPlay,  exec, playerctl play-pause"
      ",XF86AudioPause, exec, playerctl play-pause"
      "$shiftMod, N, exec, playerctl next"
      "$shiftMod, B, exec, playerctl previous"
      "$shiftMod, P, exec, playerctl play-pause"
    ];

    binde = [
      # Zoom
      "$mod, minus, exec, hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 - 0.1}')"
      "$mod, equal, exec, hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 + 0.1}')"
    ];
  };
}