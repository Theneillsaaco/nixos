{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    htop
    tree
    gnupg
    unzip
    zip
    unrar
    p7zip
    zsh
    kitty
    gnome-keyring
    libsecret
    playerctl
    sbctl
    sbsigntool
    nix-index
    geoclue2
    ffmpeg
    nix-tree
    nvd
    openssh
  ];
}