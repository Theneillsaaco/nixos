{ ... }:
{
  programs.caelestia = {
    enable = true;
    cli = {
      enable = true;
      settings.theme.enableGtk = true;
    };

    settings = {
      appearance = {
        transparency = {
          enabled = true;
          base = 0.85;
          layers = 0.8;
        };
        font.size.scale = 1;
        padding.scale = 1;
        rounding.scale = 1;
        spacing.scale = 1;
        anim.durations.scale = 1;
      };

      general = {
        apps = {
          terminal = [ "kitty" ];   # Cambia por tu terminal
          audio    = [ "pavucontrol" ];
          explorer = [ "thunar" ];
        };
        idle = {
          lockBeforeSleep = true;
          timeouts = [{ timeout = 300; idleAction = "lock"; }];
        };
      };

      bar = {
        persistent = true;
        showOnHover = true;
        workspaces = {
          activeIndicator = true;
          rounded = true;
          showWindows = true;
          shown = 5;
        };
        status = {
          showAudio    = true;
          showBattery  = true;   # Laptop → true
          showNetwork  = true;
          showBluetooth = true;
          showLockStatus = true;
          showKbLayout = false;
        };
        scrollActions = {
          volume     = true;
          workspaces = true;
          brightness = true;   # Laptop → útil
        };
      };

      dashboard = {
        enabled = true;
        showOnHover = true;
        mediaUpdateInterval = 500;
      };

      launcher = {
        actionPrefix = ">";
        maxShown = 7;
        maxWallpapers = 9;
        vimKeybinds = false;
      };

      notifs = {
        expire = true;
        defaultExpireTimeout = 3000;
        clearThreshold = 0.3;
        expandThreshold = 20;
      };

      osd.hideDelay = 2000;

      paths = {
        wallpaperDir = "~/Pictures/Wallpapers";
      };

      services = {
        useFahrenheit = false;   # Cambia a true si prefieres
        useTwelveHourClock = false;
        smartScheme = true;
        gpuType = "Intel";         # Laptop Intel/AMD
      };

      session = {
        commands = {
          logout    = [ "hyprctl" "dispatch" "exit" ];
          shutdown  = [ "systemctl" "poweroff" ];
          reboot    = [ "systemctl" "reboot" ];
          hibernate = [ "systemctl" "hibernate" ];
        };
      };
    };
  };
  
  systemd.user.services.caelestia = {
    Unit = {
      ConditionEnvironment = "XDG_CURRENT_DESKTOP=Hyprland";
    };
  };
}