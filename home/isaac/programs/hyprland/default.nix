{ pkgs, ... }:
let
  pamKwalletInit = "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init";
in {
  imports = [
    ./animations.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = null;
    portalPackage = null;
    systemd = {
      enable = false;
      variables = [ "--all" ];
    };
    configType = "lua";

    extraLuaFiles = {
      "kwallet_path" = { autoLoad = false; content = ''return "${pamKwalletInit}"''; };
      "vars" = { autoLoad = false; content = builtins.readFile ./lua/vars.lua; };
      "execs" = { autoLoad = true; content = builtins.readFile ./lua/execs.lua; };
      "keybinds" = { autoLoad = true; content = builtins.readFile ./lua/keybinds.lua; };
      "rules" = { autoLoad = true; content = builtins.readFile ./lua/rules.lua; };
      "gestures" = { autoLoad = true; content = builtins.readFile ./lua/gestures.lua; };
    };

    settings = {
      monitor = {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = 1;
      };

      env = [
        { _args = [ "XDG_CURRENT_DESKTOP" "Hyprland" ]; }
        { _args = [ "XDG_SESSION_TYPE" "wayland" ]; }
        { _args = [ "XDG_SESSION_DESKTOP" "Hyprland" ]; }
        { _args = [ "MOZ_ENABLE_WAYLAND" "1" ]; }
        { _args = [ "NIXOS_OZONE_WL" "1" ]; }
        { _args = [ "QT_QPA_PLATFORM" "wayland;xcb" ]; }
        { _args = [ "QT_QPA_PLATFORMTHEME" "kde" ]; }
        { _args = [ "XDG_MENU_PREFIX" "plasma-" ]; }
        { _args = [ "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1" ]; }
        { _args = [ "ELECTRON_OZONE_PLATFORM_HINT" "auto" ]; }
        { _args = [ "SDL_VIDEODRIVER" "wayland,x11" ]; }
        { _args = [ "CLUTTER_BACKEND" "wayland" ]; }
        { _args = [ "_JAVA_AWT_WM_NONREPARENTING" "1" ]; }
        { _args = [ "XCURSOR_THEME" "phinger-cursors-light" ]; }
        { _args = [ "XCURSOR_SIZE" "24" ]; }
      ];

      config = {
        cursor.no_hardware_cursors = false;

        general = {
          resize_on_border = true;
          gaps_in = 6;
          gaps_out = 6;
          border_size = 2;
          layout = "master";
        };

        decoration = {
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          rounding = 17;
          rounding_power = 2;
          shadow = {
            enabled = true;
            range = 15;
            render_power = 4;
          };
          
          blur = {
            enabled = true;
            size = 8;
            passes = 2;
            xray = false;
            ignore_opacity = true;
            new_optimizations = true;
            popups = true; 
            input_methods = true;
          };
        };

        master = {
          new_status = "master";
          allow_small_split = true;
          mfact = 0.5;
        };

        misc = {
          vrr = 0;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          focus_on_activate = true;
          middle_click_paste = false;
          force_default_wallpaper = 0;
          allow_session_lock_restore = true;
          animate_manual_resizes = false;
          animate_mouse_windowdragging = false;
          on_focus_under_fullscreen = 2;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        binds.scroll_event_delay = 0; 
        
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
          repeat_delay = 300;
          repeat_rate = 50;
          focus_on_close = 1;
          touchpad = {
            natural_scroll = true;
            tap_to_click = true;
            drag_lock = false;
            scroll_factor = 0.3;
          };
        };

        debug.disable_logs = false;
      };
    };
  };
}
