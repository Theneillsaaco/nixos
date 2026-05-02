{ pkgs, ... }: {
  services.xserver.enable = false;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb.layout = "us";
  
  programs.partition-manager.enable = true;
  programs.kdeconnect.enable = true;
  
  environment.systemPackages = with pkgs; [
    kdePackages.kio
    kdePackages.kio-extras
  ];
  
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
    khelpcenter
  ];
}