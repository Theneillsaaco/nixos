{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    hyprpicker
    wl-clipboard
    cliphist
    inotify-tools
    app2unit
    wireplumber
    trash-cli
    foot
    fish
    fastfetch
    starship
    btop
    jq
    eza
    papirus-icon-theme
    jetbrains-mono
  ];

  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.btop.enable = true;

  xdg.configFile."hypr".source =
    config.lib.file.mkOutOfStoreSymlink "/home/isaac/.local/share/caelestia/hypr";

  xdg.configFile."foot".source =
    config.lib.file.mkOutOfStoreSymlink "/home/isaac/.local/share/caelestia/foot";

  xdg.configFile."fish".source =
    config.lib.file.mkOutOfStoreSymlink "/home/isaac/.local/share/caelestia/fish";

  xdg.configFile."fastfetch".source =
    config.lib.file.mkOutOfStoreSymlink "/home/isaac/.local/share/caelestia/fastfetch";

  xdg.configFile."btop".source =
    config.lib.file.mkOutOfStoreSymlink "/home/isaac/.local/share/caelestia/btop";

  xdg.configFile."uwsm".source =
    config.lib.file.mkOutOfStoreSymlink "/home/isaac/.local/share/caelestia/uwsm";

  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "/home/isaac/.local/share/caelestia/starship.toml";
}