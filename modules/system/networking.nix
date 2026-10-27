{ hostName, ... }: {
  networking = {
    hostName = hostName;
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.macAddress = "stable";
    };
    
    firewall = {
      enable = true;
      allowedTCPPorts = [ 4321 54321 ];
    };
  };

  services = {
    resolved = {
      enable = true;
      settings.Resolve = {
        DNS = [ 
          "1.1.1.1#one.one.one.one"
          "9.9.9.9#dns.quad9.net"
          "8.8.8.8#dns.google"
          "1.0.0.1#one.one.one.one"
          "149.112.112.112#dns.quad9.net"
          "8.8.4.4#dns.google"
        ];
        
        DNSSEC = "allow-downgrade";
        DNSOverTLS = "opportunistic";
        FallbackDNS = [ "1.1.1.1#one.one.one.one" "8.8.8.8#dns.google" ];
        Domains = [ "~." ];
      };
    };

    geoclue2.enable = true;
  };
}
