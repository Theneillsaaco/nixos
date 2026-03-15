{ ... }:
let
  totalWorkspaces = 9;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Ventanas
      "$mod, Q, killactive"
      "$mod, F, fullscreen"
      "$mod, V, togglefloating"
      "ALT, TAB, workspace, previous"

      # Apps
      "$mod, SPACE, exec, uwsm app -- kitty"   # Cambia por tu terminal
      "$mod, B,     exec, uwsm app -- firefox"
      "$mod, E,     exec, uwsm app -- thunar"

      # Caelestia shell
      "$mod, RETURN, exec, caelestia shell drawers toggle launcher"
      "$mod, D,      exec, caelestia shell drawers toggle dashboard"
      "$mod, S,      exec, caelestia shell drawers toggle session"

      # Foco con hjkl (vim-style)
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"

      # Mover ventanas
      "$shiftMod, H, movewindow, l"
      "$shiftMod, L, movewindow, r"
      "$shiftMod, K, movewindow, u"
      "$shiftMod, J, movewindow, d"

      # Screenshot
      "$mod, Print,       exec, hyprshot -m region"
      "$shiftMod, Print,  exec, hyprshot -m output"
    ] ++ (builtins.concatLists (builtins.genList (i:
      let ws = i + 1;
      in [
        "$mod,       code:1${toString i}, workspace,      ${toString ws}"
        "$shiftMod,  code:1${toString i}, movetoworkspace, ${toString ws}"
      ]) totalWorkspaces
    ));

    bindm = [
      "$mod, mouse:272, movewindow"    # SUPER + click izquierdo → mover
      "$mod, mouse:273, resizewindow"  # SUPER + click derecho → resize
    ];

    bindel = [
      # Brillo (laptop)
      ", XF86MonBrightnessUp,   exec, brightnessctl s +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      # Volumen
      ", XF86AudioRaiseVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];
  };
}