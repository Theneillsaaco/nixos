# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ myLib, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
      ../../modules/hardware/intel.nix
      
      ../../modules/users/isaac.nix
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
  
  environment.variables.NIXOS_OZONE_WL = "1";
  
  # Dont touch this
  system.stateVersion = "25.11";
}
