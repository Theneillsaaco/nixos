{ pkgs, inputs, ... }: {
  
  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    
    kernelParams = [
      "quiet"
      "splash"
      "plymouth.use-simpledrm"
      "rd.systemd.show_status=auto"
      "udev.log_priority=3"

      "i915.enable_fbc=1"
      "i915.enable_psr=1"
      "i915.enable_fastboot=1"
    ];

    kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-bore;
    
    loader.systemd-boot.enable = false;
    
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
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