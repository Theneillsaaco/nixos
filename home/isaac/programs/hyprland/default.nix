{ pkgs, lib, ... }:
let
  inline = lib.generators.mkLuaInline;
in
{
  imports = [
    ./animations.nix
    ./bindings.nix
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

    settings = {
      mod      = { _var = "SUPER"; };
      shiftMod = { _var = "SUPER + SHIFT"; };

      # Monitor — confirmado: output = "" como catch-all
      monitor = {
        output   = "";
        mode     = "preferred";
        position = "auto";
        scale    = 1;
      };

      env = [
        { _args = [ "XDG_CURRENT_DESKTOP"              "Hyprland"    ]; }
        { _args = [ "XDG_SESSION_TYPE"                 "wayland"     ]; }
        { _args = [ "XDG_SESSION_DESKTOP"              "Hyprland"    ]; }
        { _args = [ "MOZ_ENABLE_WAYLAND"               "1"           ]; }
        { _args = [ "NIXOS_OZONE_WL"                   "1"           ]; }
        { _args = [ "ANKI_WAYLAND"                     "1"           ]; }
        { _args = [ "DISABLE_QT5_COMPAT"               "0"           ]; }
        { _args = [ "QT_QPA_PLATFORMTHEME"             "qtengine"    ]; }
        { _args = [ "QT_AUTO_SCREEN_SCALE_FACTOR"      "1"           ]; }
        { _args = [ "QT_QPA_PLATFORM"                  "wayland,xcb" ]; }
        { _args = [ "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1"        ]; }
        { _args = [ "ELECTRON_OZONE_PLATFORM_HINT"     "auto"        ]; }
        { _args = [ "SDL_VIDEODRIVER"                  "wayland,x11" ]; }
        { _args = [ "CLUTTER_BACKEND"                  "wayland"     ]; }
      ];

      # Autostart — usando hl.exec_cmd directo (igual que el código oficial de Caelestia)
      on = [
        {
          _args = [
            "hyprland.start"
            (inline ''
              function()
                hl.exec_cmd("dbus-update-activation-environment --systemd --all")
                hl.exec_cmd("systemctl --user start hyprpolkitagent")
                hl.exec_cmd("hyprctl setcursor phinger-cursors-light 24")
                hl.exec_cmd("uwsm app -- caelestia shell")
                hl.exec_cmd("uwsm app -- discord --start-minimized")
                hl.exec_cmd("uwsm app -- kdeconnect-indicator")
                hl.exec_cmd("${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init")
              end
            '')
          ];
        }
      ];

      config = {
        cursor = {
          no_hardware_cursors = false;
        };
        general = {
          resize_on_border = true;
          gaps_in          = 6;
          gaps_out         = 6;
          border_size      = 2;
          layout           = "master";
        };
        decoration = {
          active_opacity   = 1.0;
          inactive_opacity = 0.85;
          rounding         = 17;
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
          new_status       = "master"; # string desde Hyprland 0.55+
          allow_small_split = true;
          mfact            = 0.5;
        };
        misc = {
          vrr                      = 0;
          disable_hyprland_logo    = true;
          disable_splash_rendering = true;
          focus_on_activate        = true;
          middle_click_paste       = false;
        };
        input = {
          kb_layout    = "us";
          follow_mouse = 1;
          sensitivity  = 0;
          repeat_delay = 300;
          repeat_rate  = 50;
          touchpad = {
            natural_scroll = true;
            tap_to_click   = true;
            drag_lock      = false;
          };
        };
        debug = {
          disable_logs = false;
        };
      };
    };
  };
}
