{pkgs, inputs, username, myLib, ... }: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };
  
  programs.home-manager.enable = true;

  imports = [
    inputs.caelestia-shell.homeManagerModules.default
    ./isaac/programs/hyprland/default.nix
  ]
  ++ myLib.importDir ./isaac/programs
  ++ myLib.importDir ./isaac/config;

  # Home packages
  home.packages = with pkgs; [
    # Wayland utils
    wl-clipboard
    wlr-randr
    wayland-utils

    # Hyprland utils
    hyprpolkitagent
    hyprshot
    hyprpicker
    cliphist
    
    # Misc
    dconf
    glib
  ];
  
  # Variables
  home.sessionVariables = {
    # DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
  };
}
