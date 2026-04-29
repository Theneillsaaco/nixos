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
      cores = 0;
      auto-optimise-store = true;
      
      keep-going = true;
      warn-dirty = false;
      builders-use-substitutes = true;
      
      # Determinate nix requires
      lazy-trees = true;
      
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.determinate.systems"
        "https://cache.nixos.org/"
        "https://theneillsaaco-nix.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.determinate.systems-1:wup8m09p2798f09p2798f09p2798f09p2798f09p279="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "theneillsaaco-nix.cachix.org-1:l6861n9yzzvrcRmsa8xJuF2abe8R+7j++fz3j1C1/I4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      
      trusted-users = [ "root" "@wheel" ];
    };
  };
}