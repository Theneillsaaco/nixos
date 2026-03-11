{ config, pkgs, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;

  services.thermald.enable = true;

  hardware.graphics.enabled = true;

  environment.systemPackages = with pkgs; [
    intel-media-driver
    intel-gpu-tools
  ];
}