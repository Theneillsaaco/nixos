{ pkgs, ... }: {
  # Enable the systemd-boot EFI bootloader.
  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.systemd.show_status=auto"
      "udev.log_priority=3"
    ];
    
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  
  boot.plymouth = {
    enable = true;
    theme = "cross_hud";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "cross_hud" ];
      })
    ];
  };
}