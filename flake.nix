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
    
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    
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
        
        # Temporal fix
        ({ ... }: {
          nixpkgs.overlays = [
            (_: prev: {
              openldap = prev.openldap.overrideAttrs (old: {
                doCheck = !prev.stdenv.hostPlatform.isi686;
              });
            })
          ];
        })
        
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