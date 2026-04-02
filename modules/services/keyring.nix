{
  services.gnome.gnome-keyring.enable = false;
  
  security.pam.services = {
    sddm.kwallet.enable = true;
    login.kwallet.enable = true;
  };
}