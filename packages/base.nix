{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    htop
    tree
    unzip
    flatpak
    zsh
    kitty
  ];
}