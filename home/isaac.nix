{pkgs, inputs, username, ... }: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };
  
  programs.home-manager.enable = true;

  imports = [
    inputs.caelestia-shell.homeManagerModules.default
    ./isaac/programs/caelestia.nix
    ./isaac/programs/desktop-apps.nix
    ./isaac/programs/devtools-home.nix
    ./isaac/programs/hyprland/default.nix
    ./isaac/programs/starship.nix
  ];

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
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos";
      update = "sudo nix flake update --flake /etc/nixos";
      upgrade = "update && rebuild";
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
      
      source ${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
      
      precmd_functions+=(_mark_prompt_start)
    '';
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
  
  # Variables
  home.sessionVariables = {
    DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
  };
}
