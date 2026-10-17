{ pkgs, ... }: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.containers.registries.search = [ "docker.io" ];
  
  environment.systemPackages = [ pkgs.distrobox ];
}