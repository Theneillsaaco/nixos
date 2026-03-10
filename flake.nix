{
  description = "Isaac NixOS config";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }:

  let
    system = "x86_64-linux";
  in {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

      inherit system;

      modules = [

        ./hosts/laptop/configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.isaac = import ./home/isaac.nix;
        }

      ];
    };
  };
}