{ inputs, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  
  environment.systemPackages = with pkgs; [  
    qtengine
    xdg-utils
    shared-mime-info
    desktop-file-utils
  ];
  
  xdg = {
    mime.enable = true;
    icons.enable = true;
    menus.enable = true;
    
    portal = {
      enable = true;
      
      extraPortals = with pkgs; [ 
        xdg-desktop-portal-gtk
      ];
      
      config = {
        common = {
          default = [ "gtk" ];
        };
      };
    };
  };
}