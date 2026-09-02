{ pkgs, lib, inputs, ... }:
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
      discord = {
        executable = "${pkgs.discord}/bin/discord";
        profile = "${pkgs.firejail}/etc/firejail/discord.profile";
        extraArgs = [ "--env=NIXOS_OZONE_WL=1" ];
      };

      zen = {
        executable = "${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/zen";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      };
    };
  };
}