{ pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    brave
    steam
    pear-desktop
    onlyoffice-desktopeditors
    prismlauncher
  ];
}