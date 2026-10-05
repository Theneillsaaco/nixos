{
  description = "Isaac NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Kernel
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    
    # Shells
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    sung = {
      url = "github:theneillsaaco/sung";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, lanzaboote, ... }: 
  let
    system = "x86_64-linux";
    username = "isaac";
    myLib = import ./lib/importModules.nix { lib = nixpkgs.lib; };
    pkgs = nixpkgs.legacyPackages.${system};

    homeManagerBaseModule = { hostName, stateVersion, ... }: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        users.${username} = import ./home/isaac.nix;
        extraSpecialArgs = { 
          inherit inputs username myLib stateVersion hostName;
        };
      };
    };
    
    mkHost = { hostName, hostPath, stateVersion, arch ? system }:
      nixpkgs.lib.nixosSystem {
        system = arch;
        specialArgs = {
          inherit inputs username myLib stateVersion hostName;
        };
        modules = [
          hostPath
          lanzaboote.nixosModules.lanzaboote
          home-manager.nixosModules.home-manager
          homeManagerBaseModule
        ];
      };
  in {
    # old laptop hp (Intel i5-7200U)
    nixosConfigurations.hp = mkHost {
      hostName = "hp";
      hostPath = ./hosts/laptop/hp/configuration.nix;
      stateVersion = "25.11";
    };

    # lenovo new (Ryzen 7 5825U)
    nixosConfigurations.lenovo = mkHost {
      hostName = "lenovo";
      hostPath = ./hosts/laptop/lenovo/configuration.nix;
      stateVersion = "26.05";
    };

    formatter.${system} = pkgs.alejandra;

    checks.${system} = {
      statix = pkgs.runCommand "statix-check" { nativeBuildInputs = [ pkgs.statix ]; } ''
        statix check ${./.}
        touch $out
      '';

      deadnix = pkgs.runCommand "deadnix-check" { nativeBuildInputs = [ pkgs.deadnix ]; } ''
        deadnix --fail ${./.}
        touch $out
      '';
    };

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [ statix deadnix alejandra ];
    };
  };
}
