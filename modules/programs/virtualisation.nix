{ pkgs, ... }: {
  virtualisation = {
    podman.enable = true;
    docker = {
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
  
  environment.systemPackages = [ pkgs.distrobox ];
}