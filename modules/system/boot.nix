{ pkgs, inputs, ... }: {
  
  boot = {
    consoleLogLevel = 3;
    initrd = {
      verbose = false;
      kernelModules = [ "amdgpu" ];
    };
    
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=auto"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
      
      # Cifra la memoria RAM vía hardware en procesadores AMD (AMD Memory Guard / SME)
      "mem_encrypt=on"

      # Evita que procesos sin privilegios lean la memoria RAM o variables del Kernel
      "page_alloc.shuffle=1"
    ];

    kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-bore-lto;
    
    loader = {
      systemd-boot = {
        enable = false;

        configurationLimit = 5;
        
        # Directivas escritas directamente en /boot/loader/loader.conf
        extraConfig = ''
          console-mode max
          sort-key nixos
        '';
      };

      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
  
  boot.plymouth = {
    enable = true;
    theme = "sphere";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "sphere" ];
      })
    ];
  };

  security.protectKernelImage = true;
  security.lockKernelModules = false;
}