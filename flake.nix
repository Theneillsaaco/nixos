{
  description = "Isaac NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    lanzaboote.url = "github:nix-community/lanzaboote";

    # Shells
    caelestia-shell.url = "github:caelestia-dots/shell";
    
    # dotfiles = {
    #   url = "git+https://github.com/Theneillsaaco/dots-hyprland?submodules=1";
    #   flake = false;
    # };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
        
    # illogical-flake = {
    #   url = "github:Theneillsaaco/illogical-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.dotfiles.follows = "dotfiles";
    #   inputs.quickshell.follows = "quickshell";
    # };
    
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

    # Kernel
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    
    # Determinate Systems modules
    # determinate.url = "github:DeterminateSystems/determinate/main";
  };

  outputs = inputs@{ nixpkgs, home-manager, lanzaboote, ... }: 
  let
    system = "x86_64-linux";
    username = "isaac";
    myLib = import ./lib/importModules.nix { lib = nixpkgs.lib; };

    mkHost = hostPath: stateVersion: nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs username myLib stateVersion;
      };

      modules = [
        hostPath

        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        # determinate.nixosModules.default

        ({ inputs, username, ...}: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";
          
          home-manager.extraSpecialArgs = {
            inherit inputs username myLib stateVersion;
          };

          home-manager.users.${username} = 
            import ./home/isaac.nix;
        })
      ];
    };
  in {
    # old laptop hp (Intel i5-7200U)
    nixosConfigurations.hp = mkHost ./hosts/laptop/hp/configuration.nix "25.11";

    # lenovo new (Ryzen 7 5825U)
    nixosConfigurations.lenovo = mkHost ./hosts/laptop/lenovo/configuration.nix "26.05";
  };
}