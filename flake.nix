{
  description = "Isaac NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-nix = {
      url = "github:Theneillsaaco/caelestia-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.caelestia-shell.inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/laptop/configuration.nix
      
        home-manager.nixosModules.home-manager
        
        ({ pkgs, inputs, ...}:
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.isaac = import ./home/isaac.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          })
      ];
    };
  };
}