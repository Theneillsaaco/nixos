{ pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    brave
    steam
  ];
}