{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # basic
    firefox
    wget
    openssh
    fastfetch

    # development
    jq
    htop
    tree
    binutils # objdump, strings
    git

    # compression
    zip
    unzip
    unrar
    p7zip

    # security
    gnupg
    sbctl
    sbsigntool
    gnome-keyring
    libsecret

    # shell
    zsh
    fish
    kitty
    
    # multimedia
    playerctl
    ffmpeg
    easyeffects

    # system
    pciutils # lspci
    usbutils # lsusb
    psmisc # killall, pstree
    iw
    bubblewrap

    # nix
    nix-index
    nix-output-monitor
    nix-tree
    nvd
  ];
}
