{ pkgs, ... }:
{
  imports = [
    ./animations.nix
    ./bindings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = null;       # Usa el del sistema
    portalPackage = null;
    systemd = {
      enable = false;
      variables = [ "--all" ];
    };

    settings = {
      "$mod"      = "SUPER";
      "$shiftMod" = "SUPER_SHIFT";

      exec-once = [
        "dbus-update-activation-environment --systemd --all &"
        "systemctl --user start hyprpolkitagent &"
        "hyprctl setcursor phinger-cursors-light 24"
        "uwsm app -- caelestia shell"
        "uwsm app -- discord --start-minimized"
        "uwsm app -- kdeconnect-indicator"
        "uwsm app -- gnome-keyring-daemon --start --components=secrets"
      ];
      
      monitor = [
        ",preferred,auto,1"   # Laptop → auto está bien
      ];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "MOZ_ENABLE_WAYLAND,1"
        "NIXOS_OZONE_WL,1"
        "ANKI_WAYLAND,1"
        "DISABLE_QT5_COMPAT,0"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM=wayland,xcb"
        "QT_QPA_PLATFORMTHEME=qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "SDL_VIDEODRIVER,wayland,x11"
        "CLUTTER_BACKEND,wayland"
        # Intel/AMD laptop — no necesita flags de NVIDIA
      ];

      cursor.no_hardware_cursors = false;  # AMD/Intel soporta hardware cursors

      general = {
        resize_on_border = true;
        gaps_in  = 6;
        gaps_out = 6;
        border_size = 2;
        layout = "master";
      };

      decoration = {
        active_opacity   = 1.0;
        inactive_opacity = 0.85;
        rounding = 17;
        shadow = {
          enabled      = true;
          range        = 8;
          render_power = 3;
        };
        blur = {
          enabled = true;
          size    = 6;
        };
      };

      master = {
        new_status       = true;
        allow_small_split = true;
        mfact = 0.5;
      };

      misc = {
        vfr = true;
        vrr = 0;                      # Laptop → 0 a menos que tu monitor lo soporte
        disable_hyprland_logo    = true;
        disable_splash_rendering = true;
        focus_on_activate        = true;
        middle_click_paste = false;
      };

      input = {
        kb_layout    = "us";          # Cambia a tu layout
        follow_mouse = 1;
        sensitivity  = 0;
        repeat_delay = 300;
        repeat_rate  = 50;
        # Trackpad
        touchpad = {
          natural_scroll   = true;
          tap-to-click     = true;
          drag_lock        = false;
        };
      };
      
      debug = {
        disable_logs = false;
      };
    };
  };
}