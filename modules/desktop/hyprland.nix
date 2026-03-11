{ pkgs, inputs, ... }:

{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    # inputs.caelestia-shell.packages.${pkgs.system}.default
  ];
}
