{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = null;       # Usa el del sistema (NixOS module)
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "uwsm app -- caelestia shell"
      ];
      monitor = [ ",preferred,auto,1" ];
    };
  };
}