{ pkgs, inputs, ... }:
let
  zen = inputs.zen-browser.packages.${pkgs.system}.default;
in {
  home.packages = [
    zen
  ];
}