{
  description = "Isaac NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    lanzaboote.url = "github:nix-community/lanzaboote";
    caelestia-shell.url = "github:caelestia-dots/shell/v1.5.2";
    hyprland.url = "github:hyprwm/Hyprland";
    
    # Determinate Systems modules
    determinate.url = "github:DeterminateSystems/determinate/main";
  };

  outputs = inputs@{ nixpkgs, home-manager, lanzaboote, determinate, ... }: 
  let
    system = "x86_64-linux";
    username = "isaac";
    myLib = import ./lib/importModules.nix { lib = nixpkgs.lib; };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      
      specialArgs = { 
        inherit inputs username myLib;
      };

      modules = [
        ./hosts/laptop/configuration.nix
      
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        determinate.nixosModules.default
        
        ({ inputs, username, ...}: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          home-manager.users.${username} = 
            import ./home/isaac.nix;
            
          home-manager.extraSpecialArgs = {
            inherit inputs username myLib;
          };
        })
      ];
    };
  };
}