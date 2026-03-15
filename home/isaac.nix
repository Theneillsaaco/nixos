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
  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };
  
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

    oh-my-zsh = {
      enable = true;
      theme = "";
      plugins = [ "git" ];
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions.src;
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting.src;
      }
      {
        name = "zsh-autocomplete";
        src = pkgs.zsh-autocomplete.src;
      }
    ];
  };
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
