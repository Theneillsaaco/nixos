{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Chats
    discord
    signal-desktop
    
    pear-desktop # Youtube music
    onlyoffice-desktopeditors
    
    # Audio tools
    pwvucontrol
  ];
}