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

      # Cifra la memoria RAM vía hardware en procesadores AMD (AMD Memory Guard / SME)
      "mem_encrypt=on"

      # Evita que procesos sin privilegios lean la memoria RAM o variables del Kernel
      "page_alloc.shuffle=1"
      "ptdump_vma.ptdump_vma=0"
    ];

    kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-bore-lto;
    
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

  security.protectKernelImage = true;
  security.lockKernelModules = false;
}