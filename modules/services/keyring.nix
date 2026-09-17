{ pkgs, ... }: {
  security.pam.services = {
    login.kwallet.enable = true;
    sddm.kwallet.enable = true;
    hyprland.kwallet.enable = true;

    plasma-login-manager.kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;
    };
  };

  services.gnome.gnome-keyring.enable = false;

  environment.systemPackages = with pkgs; [
    kdePackages.kwallet
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager
    libsecret
  ];

  systemd.services."drkonqi-coredump-processor@".enable = false;
}
