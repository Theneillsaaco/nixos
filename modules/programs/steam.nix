{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;
    protontricks.enable = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  security.chromiumSuidSandbox.enable = true;

  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

  boot.kernelModules = [ "ntsync" ];
  services.udev.extraRules = ''
    KERNEL=="ntsync", MODE="0660", TAG+="uaccess"
  '';
}
