{
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep-since 7d --keep 5";
    };
  };
}