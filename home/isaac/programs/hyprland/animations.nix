{ lib, ... }:
let
  inline = lib.generators.mkLuaInline;
  mkCurve = name: x1: y1: x2: y2: {
    _args = [
      name
      (inline ''{ type = "bezier", points = { {${toString x1}, ${toString y1}}, {${toString x2}, ${toString y2}} } }'')
    ];
  };
in {
  wayland.windowManager.hyprland.settings = {
    curve = [
      (mkCurve "standard" 0.2 0 0 1)
      (mkCurve "emphasizedAccel" 0.3 0 0.8 0.15)
      (mkCurve "emphasizedDecel" 0.05 0.7 0.1 1)
    ];

    animation = [
      { leaf = "layersIn";  enabled = true; speed = 5; bezier = "emphasizedDecel"; style = "slide"; }
      { leaf = "layersOut"; enabled = true; speed = 4; bezier = "emphasizedAccel"; style = "slide"; }
      { leaf = "fadeLayers"; enabled = true; speed = 5; bezier = "standard"; }
      { leaf = "windowsIn";  enabled = true; speed = 5; bezier = "emphasizedDecel"; }
      { leaf = "windowsOut"; enabled = true; speed = 3; bezier = "emphasizedAccel"; }
      { leaf = "windowsMove"; enabled = true; speed = 6; bezier = "standard"; }
      { leaf = "workspaces"; enabled = true; speed = 5; bezier = "standard"; style = "slidevert"; }
      { leaf = "specialWorkspace"; enabled = true; speed = 4; bezier = "emphasizedDecel"; style = "slidefadevert 15%"; }
      { leaf = "fade";    enabled = true; speed = 6; bezier = "standard"; }
      { leaf = "fadeDim"; enabled = true; speed = 6; bezier = "standard"; }
      { leaf = "border";  enabled = true; speed = 6; bezier = "standard"; }
    ];
  };
}
