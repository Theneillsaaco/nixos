{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # inputs.caelestia-shell.packages.x86_64-linux.default
  ];
}
