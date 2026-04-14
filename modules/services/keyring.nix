{ pkgs, ... }: {
  services.gnome.gnome-keyring.enable = false;
  
  security.pam.services = {
    sddm.kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;
    };
  };
  
  security.pam.services.sddm.enableKwallet = true;
}