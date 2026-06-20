{
  wayland.windowManager.hyprland.settings = {
    bezier = [
      { _args = [ "easeOut" 0.16 1 0.3 1 ]; }
      { _args = [ "easeIn" 0.7 0 0.84 0 ]; }
      { _args = [ "easeInOut" 0.37 0 0.63 1 ]; }
      { _args = [ "easeOutBack" 0.34 1.56 0.64 1 ]; }
    ];

    animation = [
      { leaf = "windows";     enabled = true; speed = 4; bezier = "easeOutBack"; style = "slide"; }
      { leaf = "windowsOut";  enabled = true; speed = 3; bezier = "easeIn";      style = "slide"; }
      { leaf = "windowsMove"; enabled = true; speed = 4; bezier = "easeOutBack"; }
      { leaf = "fade";        enabled = true; speed = 4; bezier = "easeInOut"; }
      { leaf = "workspaces";  enabled = true; speed = 5; bezier = "easeOutBack"; style = "slidevert"; }
      { leaf = "layers";      enabled = true; speed = 3; bezier = "easeOutBack"; style = "slide"; }
    ];
  };
}