{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    corefonts
    vistafonts
    nerd-fonts
    material-icons
  ];
}