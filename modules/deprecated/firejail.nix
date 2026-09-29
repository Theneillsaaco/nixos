{ pkgs, lib, ... }:
let
  sandboxedApps = [
    "firefox"
    "discord"
    "brave"
    "signal-desktop"
    "pear-desktop"
    "onlyoffice-desktopeditors"
  ];

  mkWrappedBinaries = apps:
    lib.genAttrs apps (name: {
      executable = "${pkgs.${name}}/bin/${name}";
      profile = "${pkgs.firejail}/etc/firejail/${name}.profile";
    });
in {
  programs.firejail = {
    enable = true;

    wrappedBinaries = mkWrappedBinaries sandboxedApps // {
    };
  };
}
