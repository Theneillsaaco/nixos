{ ... }:
let
  totalWorkspaces = 9;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, Q, killactive"
      "SUPER, F, fullscreen, 0"
      "SUPER, D, fullscreen, 1"           # Maximize
      "ALT SUPER, SPACE, togglefloating"
      "SUPER, P, pin"
      "ALT, F4, killactive"
      "ALT, TAB, workspace, previous"

      # Foco con flechas
      "SUPER, Left,  movefocus, l"
      "SUPER, Right, movefocus, r"
      "SUPER, Up,    movefocus, u"
      "SUPER, Down,  movefocus, d"

      # Mover ventanas con flechas
      "SUPER_SHIFT, Left,  movewindow, l"
      "SUPER_SHIFT, Right, movewindow, r"
      "SUPER_SHIFT, Up,    movewindow, u"
      "SUPER_SHIFT, Down,  movewindow, d"

      # Mover ventanas vim-style
      "SUPER_SHIFT, H, movewindow, l"
      "SUPER_SHIFT, L, movewindow, r"
      "SUPER_SHIFT, K, movewindow, u"
      "SUPER_SHIFT, J, movewindow, d"

      # Workspaces con flechas
      "CTRL SUPER, Right, workspace, r+1"
      "CTRL SUPER, Left,  workspace, r-1"
      "SUPER, mouse_up,   workspace, +1"
      "SUPER, mouse_down, workspace, -1"

      # Mover ventana a workspace
      "SUPER_SHIFT, mouse_down, movetoworkspace, r-1"
      "SUPER_SHIFT, mouse_up,   movetoworkspace, r+1"

      # Scratchpad
      "SUPER, S, togglespecialworkspace"
      "SUPER ALT, S, movetoworkspacesilent, special"

      # Split ratio
      "SUPER, semicolon,  layoutmsg, splitratio -0.1"
      "SUPER, apostrophe, layoutmsg, splitratio +0.1"

      # Apps
      "SUPER, Return, exec, uwsm app -- foot"
      "SUPER, T,      exec, uwsm app -- foot"
      "CTRL ALT, T,  exec, uwsm app -- foot"
      "SUPER, E,      exec, uwsm app -- dolphin"
      "SUPER, W,      exec, uwsm app -- zen-beta"
      "SUPER, C,      exec, uwsm app -- zeditor"
      "CTRL SUPER, V, exec, uwsm app -- pavucontrol"
      
      # Caelestia shell
      "SUPER, N,        exec, caelestia shell drawers toggle dashboard"
      "CTRL ALT, Delete, exec, caelestia shell drawers toggle session"
      "SUPER, K, exec, caelestia shell drawers toggle all"
      "CTRL ALT, C, exec, caelestia shell notifications clear"

      # Screenshot
      "SUPER_SHIFT, S,     global, caelestia:screenshotFreeze"
      "SUPER, Print,      global, caelestia:screenshot"
      "SUPER_SHIFT, Print, global, caelestia:screenshot"
      ", Print,          exec, caelestia screenshot"

      # Color picker
      "SUPER_SHIFT, C, exec, hyprpicker -a"

      # Clipboard and emoji picker
      "SUPER, V, exec, pkill fuzzel || caelestia clipboard"
      "SUPER, Period, exec, pkill fuzzel || caelestia emoji -p"
    ] ++ (builtins.concatLists (builtins.genList (i:
      let ws = i + 1;
      in [
        "SUPER, code:1${toString i}, workspace, ${toString ws}"
        "SUPER_SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        "SUPER ALT, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
      ]) totalWorkspaces
    ));

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:274, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bindel = [
      # # Brillo
      # ",XF86MonBrightnessUp,   exec, brightnessctl set +5%"
      # ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      
      # Volumen
      ",XF86AudioRaiseVolume,  exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+"
      ",XF86AudioLowerVolume,  exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
    ];

    bindl = [
      # Audio
      ",XF86AudioMute,    exec, wpctl set-mute @DEFAULT_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      "ALT,XF86AudioMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      
      # Player
      ",XF86AudioNext,  global, caelestia:mediaNext"
      ",XF86AudioPrev,  global, caelestia:mediaPrev"
      ",XF86AudioPlay,  global, caelestia:mediaToggle"
      ",XF86AudioPause, global, caelestia:mediaToggle"
      "SUPER_SHIFT, N, global, caelestia:mediaNext"
      "SUPER_SHIFT, B, global, caelestia:mediaPrev"
      "SUPER_SHIFT, P, global, caelestia:mediaToggle"
      
      # Brightness
      ", XF86MonBrightnessUp,   global, caelestia:brightnessUp"
      ", XF86MonBrightnessDown, global, caelestia:brightnessDown"

      # Lock / suspend
      "SUPER, L, exec, caelestia shell -d"
      "SUPER, L, global, caelestia:lock"
      # "SUPER, Escape, exec, loginctl lock-session"
      # "SUPER, L, exec, loginctl lock-session"
      "SUPER_SHIFT, Escape, exec, systemctl suspend"
    ];

    binde = [
      # Zoom
      "SUPER, minus, exec, hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 - 0.1}')"
      "SUPER, equal, exec, hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float/{print $2 + 0.1}')"
    ];

    bindr = [
      # Restart caelestia shell
      "CTRL SUPER, R, exec, bash -c 'hyprctl reload; caelestia shell --kill; sleep .1; caelestia shell -d'"      
    ];
  };
}