{
  wayland.windowManager.hyprland.extraConfig = ''
    -- 1. Definición de curvas usando el nuevo método hl.curve()
    hl.curve("easeOut", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
    hl.curve("easeIn", { type = "bezier", points = { {0.7, 0}, {0.84, 0} } })
    hl.curve("easeInOut", { type = "bezier", points = { {0.37, 0}, {0.63, 1} } })
    hl.curve("easeOutBack", { type = "bezier", points = { {0.34, 1.56}, {0.64, 1} } })

    -- 2. Registro de animaciones usando el nuevo método hl.animation()
    hl.animation({ leaf = "global", enabled = true, speed = 1, bezier = "linear" })
    hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "easeOutBack", style = "slide" })
    hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "easeIn", style = "slide" })
    hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "easeOutBack" })
    hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "easeInOut" })
    hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "easeOutBack", style = "slidevert" })
    hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "easeOutBack", style = "slide" })
  '';
}
