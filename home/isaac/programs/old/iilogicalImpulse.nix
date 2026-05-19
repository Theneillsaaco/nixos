{ pkgs, ... }: {
  programs.illogical-impulse = {
    enable = true;

    dotfiles = {
      kitty.enable = true;
      starship.enable = true;
    };

    # hyprland.plugins = with pkgs; [
    #   hyprlandPlugins.hyprbars
    #   hyprlandPlugins.hyprexpo
    # ];
  };
}