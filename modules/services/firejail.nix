{ pkgs, lib, ... }:
let
  # Lista centralizada de aplicaciones a envolver con su perfil por defecto
  sandboxedApps = [
    "firefox"
    "discord"
    "brave"
    "signal-desktop"
    "pear-desktop"
    "onlyoffice-desktopeditors"
  ];

  # Genera dinámicamente la estructura que requiere NixOS sin repetir código
  mkWrappedBinaries = apps:
    lib.genAttrs apps (name: {
      executable = "${pkgs.${name}}/bin/${name}";
      profile = "${pkgs.firejail}/etc/firejail/${name}.profile";
    });
in
{
  programs.firejail = {
    enable = true;

    # Se aplican automáticamente todas las apps de la lista
    wrappedBinaries = mkWrappedBinaries sandboxedApps // {

      # Aquí defines ÚNICAMENTE las apps que necesitan argumentos adicionales     
    };
  };
}