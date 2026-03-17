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
    
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.zsh-autocomplete;
      }
    ];
  
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      share = true;
    };
  
    shellAliases = {
      ll = "ls -al";
      rebuild = "nixos-rebuild switch --flake /etc/nixos";
      update = "nix flake update /etc/nixos";
    };
  
    initContent = ''
      eval "$(starship init zsh)"
      eval "$(direnv hook zsh)"
      
      # Colores Caelestia
      cat ~/.local/state/caelestia/sequences.txt 2>/dev/null
      
      # Marcadores
      _mark_prompt_start() {
        printf '\e]133;A\e\\'
      }
      precmd_functions+=(_mark_prompt_start)
    '';
  };
  
  programs.starship = {
    enable = true;
    settings = {
      scan_timeout = 300;
    };
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
