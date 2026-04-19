{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winetricks
    
    lutris
    protonup-qt
    
    gamemode
  ];
}