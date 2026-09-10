{ pkgs, ... }: {
  programs.zsh = {
    enable = true;

    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-autocomplete";
        src = "${pkgs.zsh-autocomplete}/share/zsh-autocomplete";
        file = "zsh-autocomplete.plugin.zsh";
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
      rebuild = "nh os switch /etc/nixos#lenovo";
      update = "sudo nix flake update --flake /etc/nixos";
      boot = "nh os boot /etc/nixos#lenovo";
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

      precmd_functions+=(_mark_prompt_start)
    '';
  };
}
