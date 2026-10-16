{ myLib, ... }:{
  imports = [
    ../modules/services/openssl/oqs-provider.nix
  ]
  ++ myLib.importDir ../modules/system
  ++ myLib.importDir ../modules/programs
  ++ myLib.importDir ../modules/services
  ++ myLib.importDir ../modules/desktop
  ++ myLib.importDir ../packages;

  
  nixpkgs.config.allowUnfree = true;
  
  programs.fuse.userAllowOther = true;
  programs.zsh.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.gamemode.enable = true;

  services.flatpak.enable = true;
  security.openssl.oqs-provider.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";
}