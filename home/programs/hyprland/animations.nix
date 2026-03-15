{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bezier = [
      "easeOut,     0.16, 1,    0.3,  1"
      "easeIn,      0.7,  0,    0.84, 0"
      "easeInOut,   0.37, 0,    0.63, 1"
      "easeOutBack, 0.34, 1.56, 0.64, 1"
    ];

    animations = {
      enabled = true;
      animation = [
        "windows,     1, 4,  easeOutBack, slide"
        "windowsOut,  1, 3,  easeIn,      slide"
        "windowsMove, 1, 4,  easeOutBack"
        "fade,        1, 4,  easeInOut"
        "workspaces,  1, 5,  easeOutBack, slidevert"
        "layers,      1, 3,  easeOutBack, slide"
      ];
    };
  };
}