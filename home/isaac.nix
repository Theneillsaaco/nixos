{ pkgs, inputs, username, myLib, lib, stateVersion ? "25.11", ... }: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    inherit stateVersion;
  };

  programs.home-manager.enable = true;

  imports = [
    inputs.caelestia-shell.homeManagerModules.default
    inputs.zen-browser.homeModules.default
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
    hyprshot
    hyprpicker

    # Misc
    dconf
    glib
  ];
}
