{
  programs.caelestia = {
    enable = true;
    cli = {
      enable = true;
      settings.theme.enableGtk = true;
    };

    settings = {
      appearance = {
        deformScale = 1;
        
        transparency = {
          enabled = true;
          base = 0.85;
          layers = 0.8;
        };
        
        font = {
          scale = 1;
          clock = "Rubik";
          workspaces = "Rubik";
          
          body = {
            family = "Rubik";
          };
          mono = {
            family = "JetBrains Mono";
          };
          icon = {
            family = "Material Symbols Rounded";
          };
        };
      };

      general = {
        showOverFullscreen = false;
        mediaGifSpeedAdjustment = 300;
        sessionGifSpeed = 0.7;
        
        apps = {
          terminal = [ "foot" ];
          audio = [ "pavucontrol" ];
          explorer = [ "dolphin" ];
        };
        
        idle = {
          lockBeforeSleep = true;
          inhibitWhenAudio = true;
          timeouts = [
            { timeout = 300; idleAction = "lock"; }
            { timeout = 300; idleAction = "dpms off"; returnAction = "dpms on"; }
            { timeout = 600; idleAction = ["suspendThenHibernate"]; }
          ];
        };
      };

      bar = {
        persistent = true;
        showOnHover = true;
        dragThreshold = 20;
        
        workspaces = {
          shown = 5;
          activeIndicator = true;
          occupiedBg = false;
          showWindows = true;
          showWindowsOnSpecialWorkspaces = true;
          maxWindowIcons = 5;
          activeTrail = false;
          perMonitorWorkspaces = true;
          
          # special icons
          specialWorkspaceIcons = [ { name = "steam"; icon = "sports_esports"; } ];
          windowIcons = [ { regex = "steam(_app_(default|[0-9]+))?"; icon = "sports_esports"; } ];
        };
        
        statusIcons = [
          { id = "lockStatus"; enabled = false; }
          { id = "microphone"; enabled = false; }
          { id = "kbLayout"; enabled = false; }
          { id = "network"; enabled = true; }
          { id = "audio"; enabled = true; }
          { id = "bluetooth"; enabled = true; }
          { id = "battery"; enabled = true; }
        ];
        
        scrollActions = {
          volume = true;
          workspaces = true;
          brightness = true;
        };
        
        # Iconos pequenos
        tray = {
          background = false;
          compact = true;
          recolour = false;
        };
      };

      dashboard = {
        enabled = true;
        showOnHover = true;
      };

      launcher = {
        enabled = true;
        showOnHover = false;
        maxShown = 7;
        maxWallpapers = 9;
        specialPrefix = "@";
        actionPrefix = ">";
        enableDangerousActions = false; 
      };

      notifs = {
        expire = true;
        fullscreen = "On";
        defaultExpireTimeout = 3000;
        fullscreenExpireTimeout = 2000;
        clearThreshold = 0.3;
        expandThreshold = 20;
        actionOnClick = false;
        groupPreviewNum = 3;
        openExpanded = false;
      };

      osd.hideDelay = 2000;

      paths = {
        wallpaperDir = "~/Pictures/Wallpapers";
      };

      services = {
        useFahrenheit = false;
        useTwelveHourClock = false;
        smartScheme = true;
        gpuType = "Auto";
      };
      
      session = {
        enabled = true;
        dragThreshold = 30;
        vimKeybinds = false;
        
        commands = {
          logout = [ "logout" ];
          shutdown = [ "poweroff" ];
          reboot = [ "reboot" ];
          hibernate = [ "systemctl hibernate" ];
        };
      };
      
      background.desktopClock = {
        enabled = true;
        position = "bottom-right";
        scale = 1.0;
      };
    };
    
    systemd = {
      enable = false;
    };
  };
}