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
    # inputs.illogical-flake.homeManagerModules.default
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

  # Clean up old backups
  home.activation.cleanOldBackups = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
    $DRY_RUN_CMD find "$HOME/.config" -maxdepth 3 -name "*.backup" -type f -delete 2>/dev/null || true
  '';
    
  # Variables
  home.sessionVariables = {
    # DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
    ELECTRON_EXTRA_FLAGS = "--password-store=kwallet6";
  };
}
