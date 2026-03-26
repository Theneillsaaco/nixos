{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cloudflare-warp
  ];
  
  services.cloudflare-warp.enable = true;
}