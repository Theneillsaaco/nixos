{ pkgs, hostName, ... }: {
  programs.zsh = {
    enable = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    
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
      cat = "bat --paging=never";
      dev = "nix develop";

      fmt = "nix fmt /etc/nixos";
      check = "nix flake check /etc/nixos";
      lint = "statix check /etc/nixos && deadnix /etc/nixos";

      rebuild = "nh os switch /etc/nixos#${hostName}";
      boot = "nh os boot /etc/nixos#${hostName}";
      update = "sudo nix flake update --flake /etc/nixos";
      upgrade = "update && rebuild";
      gc = "nh clean all";
    };

    initContent = ''
      # Caelestia
      cat ~/.local/state/caelestia/sequences.txt 2>/dev/null

      # Marcadores
      _mark_prompt_start() {
        printf '\e]133;A\e\\'
      }

      precmd_functions+=(_mark_prompt_start)

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[3;5~" kill-word
      bindkey "^H" backward-kill-word
      setopt NO_CASE_GLOB
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
    '';
  };

  programs = {
    fzf.enable = true;
    bat.enable = true;
  };
}
