{ lib, ... }:
{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = "nixos";
        padding = {
          left = 2;
          right = 3;
        };
      };

      display = {
        separator = " → ";
        key.width = 0;
        color = {
          keys = "magenta";
          title = "blue";
          output = "cyan";
        };
      };

      modules = [
        "break"
        {
          type = "title";
          format = "{user-name-colored}@{host-name-colored}";
        }
        "break"

        # --- Bloque Hardware ---
        {
          type = "custom";
          format = "╭───────────────────────────────────────────────────╮";
        }
        {
          type = "host";
          key = "󰌢  PC";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "│ ├󰻠 ";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "│ ├󰢮 ";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "│ ├󰍛 ";
          keyColor = "green";
        }
        {
          type = "disk";
          key = "╰ ╰󰋊 ";
          keyColor = "green";
          folders = "/";
        }
        {
          type = "custom";
          format = "╰───────────────────────────────────────────────────╯";
        }

        "break"

        # --- Bloque Software ---
        {
          type = "custom";
          format = "╭───────────────────────────────────────────────────╮";
        }
        {
          type = "os";
          key = "󱄅  OS";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "│ ├󰌽 ";
          keyColor = "yellow";
        }
        {
          type = "uptime";
          key = "│ ├󰅐 ";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "│ ├󰏖 ";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "│ ├󰖲 ";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "│ ├󱆃 ";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = "╰ ╰󰆍 ";
          keyColor = "yellow";
        }
        {
          type = "custom";
          format = "╰───────────────────────────────────────────────────╯";
        }

        "break"

        # --- Bloque Batería ---
        {
          type = "custom";
          format = "╭───────────────────────────────────────────────────╮";
        }
        {
          type = "battery";
          key = "│ 󰁹 ";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "╰───────────────────────────────────────────────────╯";
        }

        "break"
        {
          type = "colors";
          symbol = "circle";
          paddingLeft = 2;
        }
        "break"
      ];
    };
  };
}