{ pkgs, ... }: {
  hardware.cpu.amd.updateMicrocode = true;

  # Zen mobile power management (5825U)
  boot.kernelParams = [
    "amd_pstate=active"
  ];

  # Power management daemon
  powerManagement.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Drivers (Vega 8 iGPU via amdgpu)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # some utils
  environment.systemPackages = with pkgs; [
    radeontop
    mesa-demos
    vulkan-tools
    libva-utils

    SDL
    SDL2
  ];
}
