{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Chats
    discord
    signal-desktop
    element-desktop
    
    pear-desktop # Youtube music
    onlyoffice-desktopeditors
    
    # Audio tools
    pwvucontrol
  ];
}