{pkgs, ... }:

{
  home.username = "isaac";
  home.homeDirectory = "/home/isaac";
  home.stateVersion = "25.11";

  imports = [
    ./programs/desktop-apps.nix
    ./programs/devtools-home.nix
  ];

  # Home packages
  home.packages = with pkgs; [
    
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