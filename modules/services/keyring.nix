{ pkgs, ... }: {
  security.pam.services = {
    login.kwallet.enable = true;  # package ya lo fuerza plasma6.nix a Qt6, no lo repitas
    sddm.kwallet.enable = true;
    hyprland.kwallet.enable = true;
    
    plasma-login-manager.kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;  # este SÍ hace falta
    };
  };
  services.desktopManager.plasma6.enable = true;
  
  services.gnome.gnome-keyring.enable = false;

  environment.systemPackages = with pkgs; [
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager
    libsecret # Útil para probar con 'secret-tool'
  ];

  systemd.services."drkonqi-coredump-processor@".enable = false;
  
  systemd.user.services."dbus-:1.2-org.kde.kwalletd6@3.service" = {
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "1";
    };
  };
}
