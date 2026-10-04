{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    protontricks.enable = true;
    extraPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  security.chromiumSuidSandbox.enable = true;
}
