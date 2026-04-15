{
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 4321 54321 ];
  };
  
  # Set DNS nameservers
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  
  services.resolved.enable = true;
}
