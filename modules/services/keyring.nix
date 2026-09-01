{ pkgs, ... }: {
  security.pam.services = {
    login.kwallet.enable = true;
    sddm.kwallet.enable = true;
    hyprland.kwallet.enable = true;
    plasma-login-manager.kwallet.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  
  services.gnome.gnome-keyring.enable = false;

  environment.systemPackages = with pkgs; [
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager
    libsecret # Útil para probar con 'secret-tool'
  ];
}
