{
  description = "Isaac NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    lanzaboote.url = "github:nix-community/lanzaboote";
    
    caelestia-shell.url = "github:caelestia-dots/shell";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = inputs@{ nixpkgs, home-manager, lanzaboote, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/laptop/configuration.nix
      
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        
        ({ inputs, ...}: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.isaac = import ./home/isaac.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        })
      ];
    };
  };
}