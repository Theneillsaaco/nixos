{ inputs, ... }: {
  nix = {
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    registry.nixpkgs.flake = inputs.nixpkgs;
    
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      
      max-jobs = "auto";
      cores = 0;

      keep-going = true;
      warn-dirty = false;
      builders-use-substitutes = true;
      eval-cache = true;

      nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
      download-buffer-size = 524288000;
      
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://theneillsaaco-nix.cachix.org"
        "https://attic.xuyh0120.win/lantian"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "theneillsaaco-nix.cachix.org-1:l6861n9yzzvrcRmsa8xJuF2abe8R+7j++fz3j1C1/I4="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      ];
      
      trusted-users = [ "root" "@wheel" ];
    };

    # gc = {
    #   automatic = true;
    #   dates = "daily";
    #   options = "--delete-older-than 7d";
    # };
  };
}
