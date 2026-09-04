# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, myLib, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/hardware/amd.nix
      ../../modules/users/isaac.nix
      ../../modules/optional/tpm-unlock.nix
    ] ++ myLib.importDir ../../modules/system
      ++ myLib.importDir ../../modules/programs
      ++ myLib.importDir ../../modules/services
      ++ myLib.importDir ../../modules/desktop
      ++ myLib.importDir ../../packages;

  nixpkgs.config.allowUnfree = true;
  
  programs.zsh.enable = true;
  services.flatpak.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  
  programs.gamemode.enable = true;
  security.allowUserNamespaces = true;
  
  environment.variables.NIXOS_OZONE_WL = "1";

  boot.loader.efi.canTouchEfiVariables = true;

  # Resume from swap on boot
  boot.resumeDevice = "/dev/disk/by-uuid/2350b033-c332-4a13-9397-ab471fc83723";
  
  # Dont touch this
  system.stateVersion = "26.05";
}
