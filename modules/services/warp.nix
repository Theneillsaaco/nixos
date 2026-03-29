{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cloudflare-warp
    
    # fix warp
    (writeShellScriptBin "warp-off" ''
      warp-cli disconnect
      sudo systemctl restart systemd-resolved
      sudo systemctl restart NetworkManager
    '')
    (writeShellScriptBin "warp-on" ''
      warp-cli connect
    '')
  ];
  
  services.cloudflare-warp = {
    enable = true;
    openFirewall = true;
  };
  
  # Unfortunately, this is necessary for it to work
  networking.firewall.checkReversePath = "loose";
}