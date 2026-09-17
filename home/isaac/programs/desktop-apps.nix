{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Chats
    discord
    signal-desktop
    element-desktop

    pear-desktop # Youtube music

    # Audio tools
    pwvucontrol

    # office
    onlyoffice-desktopeditors
  ];
}
