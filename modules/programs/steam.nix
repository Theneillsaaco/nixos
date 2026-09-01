{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Para Steam Remote Play
    dedicatedServer.openFirewall = true; # Para servidores locales
    gamescopeSession.enable = true; # Útil si usas Gamescope o Hyprland
  };
}