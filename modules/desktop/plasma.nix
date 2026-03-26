{ pkgs, ... }: {
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb.layout = "us";
  
  programs.partition-manager.enable = true;
  programs.kdeconnect.enable = true;
  
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
    khelpcenter
  ];
}