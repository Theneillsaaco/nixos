{ pkgs, lib, ... }:
let
  # Lista centralizada de aplicaciones a envolver con su perfil por defecto
  sandboxedApps = [
    "firefox"
    "discord"
    "signal-desktop"
    "pear-desktop"
    "onlyoffice-desktopeditors"
  ];

  # Genera dinámicamente la estructura que requiere NixOS sin repetir código
  mkWrappedBinaries = apps:
    lib.genAttrs apps (name: {
      executable = "${pkgs.${name}}/bin/${name}";
      profile = "${pkgs.firejail}/etc/firejail/${name}.profile";
      desktop = "${pkgs.${name}}/share/applications/${name}.desktop";
    });
in
{
  programs.firejail = {
    enable = true;

    # Se aplican automáticamente todas las apps de la lista
    wrappedBinaries = mkWrappedBinaries sandboxedApps // {

      # Aquí defines ÚNICAMENTE las apps que necesitan argumentos adicionales
      brave = {
        executable = "${pkgs.brave}/bin/brave";
        profile = "${pkgs.firejail}/etc/firejail/brave.profile";
        desktop = "${pkgs.brave}/share/applications/brave-browser.desktop";
      };
     
      discord = {
        executable = "${pkgs.discord}/bin/discord";
        profile = "${pkgs.firejail}/etc/firejail/discord.profile";
        desktop = "${pkgs.discord}/share/applications/discord.desktop";
        extraArgs = [ "--env=NIXOS_OZONE_WL=1" ]; # Soporte Wayland si lo usas
      };
    };
  };
}