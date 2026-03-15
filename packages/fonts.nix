{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    corefonts
    vista-fonts
    material-icons
    nerd-fonts._0xproto
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
}