{ pkgs, ... }:

let
  pamKwalletInit = "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init";
in {
  imports = [
    ./animations.nix
    ./cursor.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";

    systemd = {
      enable = false;
      variables = [ "--all" ];
    };

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

      env = import ./env.nix;
      config = import ./settings.nix;
    };
  };
}