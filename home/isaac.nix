{ pkgs, ... }:

{
  home.username = "isaac";
  home.homeDirectory = "/home/isaac";
  home.stateVersion = "25.11";

  imports = [
    ./programs/desktop-apps.nix
  ];

  # Home packages
  home.packages = with pkgs; [
    jetbrains-toolbox
    
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

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git"];
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
      }
      {
        name = "zsh-autocomplete";
        src = pkgs.zsh-autocomplete;
      }
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}