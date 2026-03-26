{
  services.gnome.gnome-keyring.enable = false;
  
  security.pam.services.sddm.kwallet.enable = true;
  security.pam.services.login.kwallet.enable = true;
  
  security.pam.services.hyprland.kwallet.enable = true;
}