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
          family = {
            clock = "Rubik";
            sans = "Rubik";
            mono = "JetBrains Mono";
            material = "Material Symbols Rounded";
          };
          size.scale = 1;
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
        
        status = {
          showAudio = true;
          showBattery = true;
          
          showNetwork = true;

          showBluetooth = true;
          showLockStatus = false;
          showKbLayout = false;
        };
        
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
        enable = true;
        showOnHover = false;
        maxShown = 7;
        maxWallpapers = 9;
        specialPrefix = "@";
        actionPrefix = ">";
        enableDangerousActions = false; 
      
        actions = [
          { 
            name = "Calculator";
            icon = "calculate";
            description = "Do simple math equations (powered by Qalc)";
            command = ["autocomplete" "calc"];
            enabled = true; 
            dangerous = false;
          }
          { 
            name = "Scheme"; 
            icon = "palette";
            description = "Change the current colour scheme";
            command = ["autocomplete" "scheme"];
            enabled = true; 
            dangerous = false;
          }
          { 
            name = "Wallpaper"; 
            icon = "image"; 
            description = "Change the current wallpaper";
            command = ["autocomplete" "wallpaper"]; 
            enabled = true;
            dangerous = false;
          }
          { 
            name = "Variant"; 
            icon = "colors"; 
            description = "Change the current scheme variant";
            command = ["autocomplete" "variant"]; 
            enabled = true; 
            dangerous = false;
          }
          { name = "Random";
            icon = "casino"; 
            description = "Switch to a random wallpaper";
            command = ["caelestia" "wallpaper" "-r"]; 
            enabled = true; 
            dangerous = false;
          }
          { name = "Light";
            icon = "light_mode"; 
            description = "Change the scheme to light mode";
            command = ["setMode" "light"];
            enabled = true;
            dangerous = false;
          }
          { 
            name = "Dark";
            icon = "dark_mode";
            description = "Change the scheme to dark mode";
            command = ["setMode" "dark"];
            enabled = true; 
            dangerous = false; 
          }
          { 
            name = "Shutdown";
            icon = "power_settings_new";
            description = "Shutdown the system";
            command = ["systemctl" "poweroff"];
            enabled = true;
            dangerous = true;
          }
          { 
            name = "Reboot";
            icon = "cached"; 
            description = "Reboot the system";
            command = ["systemctl" "reboot"];
            enabled = true; 
            dangerous = true; 
          }
          { 
            name = "Logout";
            icon = "exit_to_app"; 
            description = "Log out of the current session"; 
            command = ["loginctl" "terminate-user" ""]; 
            enabled = true; 
            dangerous = true;
          }
          { 
            name = "Lock"; 
            icon = "lock"; 
            description = "Lock the current session"; 
            command = ["loginctl" "lock-session"]; 
            enabled = true;
            dangerous = false; 
          }
          { 
            name = "Sleep";
            icon = "bedtime";
            description = "Suspend then hibernate";
            command = ["systemctl" "suspend-then-hibernate"];
            enabled = true; 
            dangerous = false;
          }
          { 
            name = "Settings";
            icon = "settings"; 
            description = "Configure the shell"; 
            command = ["caelestia" "shell" "nexus" "open"];
            enabled = true; 
            dangerous = false;
          }
        ];
      };

      notifs = {
        expire = true;
        fullscreen = "on";
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
        gpuType = "Intel";
      };
      
      session = {
        enabled = true;
        dragThreshold = 30;
        vimKeybinds = false;
        
        commands = {
          logout = [ "hyprctl" "dispatch" "exit" ];
          shutdown = [ "systemctl" "poweroff" ];
          reboot = [ "systemctl" "reboot" ];
          hibernate = [ "systemctl" "hibernate" ];
        };
      };
      
      utilities = {
        enable = true;
        maxToasts = 4;
        
        vpn = {
          enable = true;
          provider = [
            {
              name = "warp";
              displayName = "Cloudflare WARP";
            }
          ];
        };
      };
      
      background.desktopClock = {
        enabled = true;
        position = "bottom-right";
        scale = 1.0;
      };
    };
  };
  
  systemd.user.services.caelestia = {
    Unit = {
      ConditionEnvironment = "XDG_CURRENT_DESKTOP=Hyprland";
    };
  };
}