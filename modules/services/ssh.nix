{
  services.openssh = {
    enable = true;

    openFirewall = false;
    
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
