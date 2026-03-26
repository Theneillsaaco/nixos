{
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      
      auto-optimise-store = true;
    };
  };
  
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };
}