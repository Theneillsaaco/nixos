{ pkgs, ... }: {
  virtualisation = {
    podman.enable = true;
    docker.enable = true;
  };
  
  environment.systemPackages = [ pkgs.distrobox ];
}