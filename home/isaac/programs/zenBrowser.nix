{ pkgs, inputs, ... }:
let
  zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  home.packages = [
    zen
  ];
}