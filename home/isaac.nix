{pkgs, inputs, ... }:

{
  home.username = "isaac";
  home.homeDirectory = "/home/isaac";
  home.stateVersion = "25.11";

  imports = [
    inputs.caelestia-shell.homeManagerModules.default
    ./programs/caelestia.nix
    ./programs/desktop-apps.nix
    ./programs/devtools-home.nix
    ./programs/hyprland/default.nix
  ];

  # Home packages
  home.packages = with pkgs; [
    # Wayland utils
    wl-clipboard
    wlr-randr
    wayland-utils
    # Qt theming
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    # Hyprland utils
    hyprpolkitagent
    hyprshot
    hyprpicker
    cliphist
    # Misc
    dconf
    glib
  ];
  
  # Configure programs

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Theneillsaaco";
        email = "isaacdepena18@gmail.com";
      };
    };
  };

  programs.zsh = {
    enable = true;
  
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
  
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      share = true;
    };
  
    shellAliases = {
      ll = "ls -al";
      rebuild = "nh os switch --flake /etc/nixos";
      update = "nix flake update /etc/nixos";
      clean = "nh clean all";
    };
  
    initContent = ''
      eval "$(starship init zsh)"
    '';
  };
  
  programs.starship = {
    enable = true;
  };
  
  programs.kitty = {
    enable = true;
    
    settings = {
      confirm_os_window_close = -1;
    };
  };
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
