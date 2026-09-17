{
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 4321 54321 ];
    };
  };

  services = {
    resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = "allow-downgrade";
        FallbackDNS = [ "1.1.1.1" "8.8.8.8" ];
      };
    };

    geoclue2.enable = true;
  };
}
