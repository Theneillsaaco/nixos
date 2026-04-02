# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../../modules/system/boot.nix
      ../../modules/system/networking.nix
      ../../modules/system/locale.nix
      ../../modules/system/nix.nix
      ../../modules/system/swap.nix

      ../../modules/desktop/plasma.nix
      ../../modules/desktop/sddm.nix
      ../../modules/desktop/hyprland.nix
      
      ../../modules/hardware/intel.nix

      ../../modules/services/audio.nix
      ../../modules/services/printing.nix
      ../../modules/services/keyring.nix
      ../../modules/services/warp.nix
      ../../modules/services/bluetooth.nix
      ../../modules/services/btrfs.nix

      ../../modules/programs/devtools.nix
      ../../modules/programs/java.nix
      ../../modules/programs/postgres.nix
      ../../modules/programs/nix-ld.nix
      
      ../../modules/users/isaac.nix

      ../../packages/base.nix
      ../../packages/fonts.nix
    ];

  nixpkgs.config.allowUnfree = true;
  
  programs.zsh.enable = true;
  services.flatpak.enable = true;
  
  environment.variables.NIXOS_OZONE_WL = "1";
  
  system.stateVersion = "25.11";
}
