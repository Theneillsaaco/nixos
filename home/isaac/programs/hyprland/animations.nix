{ lib, ... }:
let
  inline = lib.generators.mkLuaInline;
  mkCurve = name: x1: y1: x2: y2:
    {
      _args = [
        name
        (inline ''{ type = "bezier", points = { {${toString x1}, ${toString y1}}, {${toString x2}, ${toString y2}} } }'')
      ];
    };
in
{
  wayland.windowManager.hyprland.settings = {
    # API nueva: hl.curve(NAME, { type = "bezier", points = { {X0,Y0}, {X1,Y1} } })
    # Los puntos X0,Y0,X1,Y1 son los mismos 2 puntos de control intermedios
    # que ya usaba el `bezier = name, x1, y1, x2, y2` de hyprlang clásico.
    curve = [
      (mkCurve "easeOut"     0.16 1    0.3  1)
      (mkCurve "easeIn"      0.7  0    0.84 0)
      (mkCurve "easeInOut"   0.37 0    0.63 1)
      (mkCurve "easeOutBack" 0.34 1.56 0.64 1)
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
