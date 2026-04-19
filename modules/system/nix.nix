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
      
      # Determinate nix requires
      lazy-trees = true;
      
      substituters = [
        "https://theneillsaaco-nix.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "theneillsaaco-nix.cachix.org-1:l6861n9yzzvrcRmsa8xJuF2abe8R+7j++fz3j1C1/I4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      
      trusted-users = [ "root" "@wheel" ];
    };
  };
}