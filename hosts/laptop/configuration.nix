# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../../modules/system/boot.nix
      ../../modules/system/networking.nix
      ../../modules/system/locale.nix
      ../../modules/system/nix.nix

      ../../modules/desktop/plasma.nix
      
      ../../modules/hardware/intel.nix

      ../../modules/services/audio.nix
      ../../modules/services/printing.nix

      ../../modules/programs/devtools.nix
      ../../modules/programs/java.nix

      ../../modules/users/isaac.nix

      ../../packages/base.nix
    ];

  nixpkgs.config.allowUnfree = true;
  
  programs.hyprland.enable = true;
  
  programs.zsh.enable = true;
  programs.kdeconnect.enable = true;
  services.flatpak.enable = true;
  
  system.stateVersion = "25.11";
}
