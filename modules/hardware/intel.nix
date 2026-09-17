{ pkgs, ... }: {
  hardware.cpu.intel.updateMicrocode = true;

  boot.kernelParams = [
    "i915.enable_fbc=1"
    "i915.enable_psr=1"
    "i915.enable_fastboot=1"
  ];

  # Power management daemon
  powerManagement.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.thermald.enable = true;

  # Drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

  # some utils
  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    mesa-demos
    vulkan-tools
    libva-utils

    SDL
    SDL2
  ];
}
