{
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 4321 54321 ];
  };
  
  services.resolved.enable = true;
}
