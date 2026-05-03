{ pkgs, inputs, ... }:

let
  # ── Zen base ─────────────────────────────
  zen =
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta-unwrapped;

  # ── fx-autoconfig (NECESARIO para Sine) ──
  zen-autoconfig = zen.overrideAttrs (old: rec {
    libName = builtins.head (builtins.attrNames (builtins.readDir "${old.out}/lib"));
  
    postInstall = (old.postInstall or "") + ''
      libDir=$(find $out/lib -maxdepth 1 -type d -name "zen-bin*" | head -n1)
  
      echo "Using libDir: $libDir"
  
      chmod -R u+w "$libDir"
  
      cp ${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
        sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
      }} "$libDir/config.js"
  
      mkdir -p "$libDir/defaults/pref"
  
      cp ${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/defaults/pref/config-prefs.js";
        sha256 = "sha256-a/0u0TnRj/UXjg/GKjtAWFQN2+ujrckSwNae23DBfs4=";
      }} "$libDir/defaults/pref/config-prefs.js"
    '';
  });

  # ── Sine (DECLARATIVO) ───────────────────
  sine = pkgs.fetchFromGitHub {
    owner = "CosmoCreeper";
    repo = "Sine";
    rev = "main"; # puedes fijar commit luego
    sha256 = "sha256-zgqL0S9zK7SPVFqA6Qb6DgGCzNEoyk0t3EbTQ0NjiA4=";  # deja vacío → copia el hash que te dé nix
  };

  profile = ".config/zen/c2tfi4s0.Default Profile";

in {

  # ── instalar Zen ─────────────────────────
  home.packages = [
    zen-autoconfig
  ];

  # ── Caelestia templates ──────────────────
  xdg.configFile."caelestia/templates/zenChrome.css".source = ./zenChrome.css;
  xdg.configFile."caelestia/templates/zenContent.css".source = ./zenContent.css;

  # ── Sine mods ────────────────────────────
  home.file."${profile}/sine-mods/css-hot-reload/css-reload.uc.js".source = ./css-reload.uc.js;

  home.file."${profile}/sine-mods/css-hot-reload/mod.json".source = ./mod.json;

  home.file."${profile}/sine-mods/mods.json".text = ''
  {
    "css-hot-reload": {
      "id": "css-hot-reload",
      "name": "CSS Hot Reload",
      "enabled": true,
      "scripts": {
        "css-reload.uc.js": {
          "include": ["chrome://browser/content/browser.xhtml"]
        }
      }
    }
  }
  '';

  # ── Activaciones ─────────────────────────
  home.activation = {

    # instalar Sine engine (Nix way)
    installSine = ''
      mkdir -p ~/${profile}/chrome

      if [ ! -d ~/${profile}/chrome/JS ]; then
        cp -r ${sine}/chrome/* ~/${profile}/chrome/
      fi
    '';

    # symlinks Caelestia → Zen
    zenSymlinks = ''
      mkdir -p ~/${profile}/chrome

      ln -sf ~/.local/state/caelestia/theme/zenChrome.css \
        ~/${profile}/chrome/userChrome.css

      ln -sf ~/.local/state/caelestia/theme/zenContent.css \
        ~/${profile}/chrome/userContent.css
    '';

    # carpeta estado
    caelestiaState = ''
      mkdir -p ~/.local/state/caelestia/theme
    '';
  };
}