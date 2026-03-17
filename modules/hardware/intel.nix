{ pkgs, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;

  services.thermald.enable = true;
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver 
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
  ];
}