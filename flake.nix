{
  description = "Isaac NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    caelestianix = {
      url = "github:Xellor-Dev/caelestia-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, caelestianix, ... }:

  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    hmModules = home-manager.nixosModules.home-manager;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      
      modules = [
        ./hosts/laptop/configuration.nix

        hmModules

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          
          home-manager.extraSpecialArgs = {
            inherit caelestianix;
          };
          
          home-manager.users.isaac = import ./home/isaac.nix;
        }
      ];
    };
  };
}