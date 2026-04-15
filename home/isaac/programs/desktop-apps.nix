{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Chats
    discord
    signal-desktop
    
    brave
    steam
    pear-desktop # Youtube music
    onlyoffice-desktopeditors
    
    # Audio tools
    pwvucontrol
  ];
}