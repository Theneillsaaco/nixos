{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # basic
    firefox
    wget 
    openssh
    git
    
    # development
    jq
    htop
    tree
    binutils # objdump, strings
    
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
    kitty
    fish
    
    # multimedia
    playerctl
    ffmpeg
    
    geoclue2
    
    # system
    pciutils      # lspci
    usbutils      # lsusb
    psmisc        # killall, pstree
    
    # nix
    nix-index
    nix-output-monitor  # Mejor salida para builds de Nix
    nix-tree
    nvd
  ];
}