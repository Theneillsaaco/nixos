{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    
    lutris
    protonup-qt
  ];
}