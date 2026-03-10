{ config, pkgs, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;

  services.thermald.enable = true;

  hardware.opengl.enable = true;

  environment.systemPackages = with pkgs; [
    intel-media-driver
    intel-gpu-tools
  ];
}