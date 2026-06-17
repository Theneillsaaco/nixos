{ pkgs, lib, ... }: {
  imports = [
    ./animations.nix
    ./bindings.nix
  ];

  home.file.".config/hypr/launcher.lua".text = ''
    -- Forzar la entrada al submapa global al iniciar
    hyprland.dispatch("submap", "global")

    -- Definición del submapa global
    hyprland.submap("global", function()
        -- Binds específicos usando el nuevo formato de Lua
        hyprland.bindi("Super", "Super_L", "global", "caelestia:launcher")
        hyprland.binditn("Super", "catchall", "global", "caelestia:launcherInterrupt")
        
        hyprland.bind("Ctrl", "Super_L", "global", "caelestia:launcherInterrupt")
        hyprland.bind("Ctrl", "Super_R", "global", "caelestia:launcherInterrupt")
        
        -- Binds de ratón
        hyprland.bind("Super", "mouse:272", "global", "caelestia:launcherInterrupt")
        hyprland.bind("Super", "mouse:273", "global", "caelestia:launcherInterrupt")
        hyprland.bind("Super", "mouse:274", "global", "caelestia:launcherInterrupt")
        hyprland.bind("Super", "mouse:275", "global", "caelestia:launcherInterrupt")
        hyprland.bind("Super", "mouse:276", "global", "caelestia:launcherInterrupt")
        hyprland.bind("Super", "mouse:277", "global", "caelestia:launcherInterrupt")
        hyprland.bind("Super", "mouse_up", "global", "caelestia:launcherInterrupt")
        hyprland.bind("Super", "mouse_down", "global", "caelestia:launcherInterrupt")
    end)
  '';

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

    extraConfig = lib.mkOrder 50 ''
      hl.source("~/.config/hypr/launcher.lua")

      hl.config({
        monitor = { ",preferred,auto,1" },

        env = {
          "XDG_CURRENT_DESKTOP,Hyprland",
          "XDG_SESSION_TYPE,wayland",
          "XDG_SESSION_DESKTOP,Hyprland",
          "MOZ_ENABLE_WAYLAND,1",
          "NIXOS_OZONE_WL,1",
          "ANKI_WAYLAND,1",
          "DISABLE_QT5_COMPAT,0",
          "QT_QPA_PLATFORMTHEME,qtengine",
          "QT_AUTO_SCREEN_SCALE_FACTOR,1",
          "QT_QPA_PLATFORM=wayland,xcb",
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1",
          "ELECTRON_OZONE_PLATFORM_HINT,auto",
          "SDL_VIDEODRIVER,wayland,x11",
          "CLUTTER_BACKEND,wayland",
        },

        cursor = {
          no_hardware_cursors = false,
        },

        general = {
          resize_on_border = true,
          gaps_in = 6,
          gaps_out = 6,
          border_size = 2,
          layout = "master",
        },

        decoration = {
          active_opacity = 1.0,
          inactive_opacity = 0.85,
          rounding = 17,
          shadow = {
            enabled = true,
            range = 8,
            render_power = 3,
          },
          blur = {
            enabled = true,
            size = 6,
          },
        },

        master = {
          new_status = true,
          allow_small_split = true,
          mfact = 0.5,
        },

        misc = {
          vrr = 0,
          disable_hyprland_logo = true,
          disable_splash_rendering = true,
          focus_on_activate = true,
          middle_click_paste = false,
        },

        input = {
          kb_layout = "us",
          follow_mouse = 1,
          sensitivity = 0,
          repeat_delay = 300,
          repeat_rate = 50,

          touchpad = {
            natural_scroll = true,
            ["tap-to-click"] = true,
            drag_lock = false,
          },
        },

        debug = {
          disable_logs = false,
        },
      })

      hl.on("hyprland.start", function ()
        hl.exec_cmd("dbus-update-activation-environment --systemd --all")
        hl.exec_cmd("systemctl --user start hyprpolkitagent")
        hl.exec_cmd("hyprctl setcursor phinger-cursors-light 24")
        hl.exec_cmd("uwsm app -- caelestia shell")
        hl.exec_cmd("uwsm app -- discord --start-minimized")
        hl.exec_cmd("uwsm app -- kdeconnect-indicator")
        hl.exec_cmd("${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init")
      end)
    '';
  };
}