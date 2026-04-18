{
  nix = {
    # gc = {
    #   automatic = true;
    #   dates = "daily";
    #   options = "--delete-older-than 7d";
    # };
    
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = "auto";
      
      auto-optimise-store = true;
      # lazy-trees = true; # I don't have determinate nix :'(
      
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://theneillsaaco-nix.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "theneillsaaco-nix.cachix.org-1:l6861n9yzzvrcRmsa8xJuF2abe8R+7j++fz3j1C1/I4="
      ];
      
      trusted-users = [ "root" "alice" "@wheel" ];
    };
  };
}