{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    htop
    tree
    unzip
    zip
    unrar
    p7zip
    flatpak
    zsh
    kitty
    gnome-keyring
    libsecret
    playerctl
    sbctl
    sbsigntool
  ];
}