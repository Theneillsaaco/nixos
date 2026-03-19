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
    gnome-keyring
    libsecret
    playerctl
  ];
}