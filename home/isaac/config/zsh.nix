{ pkgs, ... }: {
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
      ll = "ls -alh";
      rebuild = "nh os switch";
      update = "sudo nix flake update --flake /etc/nixos";
      boot = "nh os boot";
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
}