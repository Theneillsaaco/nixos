{ pkgs, ... }: {
  services.xserver.enable = false;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb.layout = "us";

  programs.partition-manager.enable = true;
  programs.kdeconnect.enable = true;

  security.pam.services.login.kwallet.enable = true;
  
  environment.systemPackages = with pkgs; [
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kate
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
    khelpcenter
  ];
}
