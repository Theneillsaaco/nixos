{ pkgs, ... }:

{
  home.username = "isaac";
  home.homeDirectory = "/home/isaac";
  home.stateVersion = "25.11";

  imports = [
    ./programs/desktop-apps.nix
    ./programs/desktop-apps.nix
  ];

  home.packages = with pkgs; [
    jetbrains-toolbox
    
  ];

  programs.git = {
    enable = true;
    userName = "Theneillsaaco";
    userEmail = "isaacdepena18@gmail.com";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}