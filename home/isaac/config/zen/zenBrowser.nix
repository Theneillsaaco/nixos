{  inputs, pkgs, ... }: 
let
  zen =
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta-unwrapped;

  zen-autoconfig = zen.overrideAttrs (old: rec {
    libName = "zen-bin";

    configjs = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
      sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
    };

    configprefs = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/defaults/pref/config-prefs.js";
      sha256 = "sha256-a/0u0TnRj/UXjg/GKjtAWFQN2+ujrckSwNae23DBfs4=";
    };

    postInstall = (old.postInstall or "") + ''
      libDir=$(find $out/lib -maxdepth 1 -type d -name "zen-bin*" | head -n1)
    
      chmod -R u+w "$libDir"
      cp ${configjs} "$libDir/config.js"
    
      mkdir -p "$libDir/defaults/pref"
      cp ${configprefs} "$libDir/defaults/pref/config-prefs.js"
    '';
  });

in {
  # ⚠️ NO usar programs.zen-browser
  home.packages = [
    zen-autoconfig
  ];

  # Templates
  xdg.configFile."caelestia/templates/zenChrome.css".source = ./zenChrome.css;
  xdg.configFile."caelestia/templates/zenContent.css".source = ./zenContent.css;

  # Sine mods
  home.file.".config/zen/c2tfi4s0.Default Profile/sine-mods/css-hot-reload/css-reload.uc.js".source = ./css-reload.uc.js;

  home.file.".config/zen/c2tfi4s0.Default Profile/sine-mods/css-hot-reload/mod.json".source = ./mod.json;

  home.file.".config/zen/c2tfi4s0.Default Profile/sine-mods/mods.json".text = ''
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

  # Activations
  home.activation.installSine = ''
    if [ ! -d ~/.config/zen/c2tfi4s0.Default\ Profile/chrome/JS ]; then
      git clone https://github.com/CosmoCreeper/Sine /tmp/sine
  
      cp -r /tmp/sine/chrome/* \
        ~/.config/zen/c2tfi4s0.Default\ Profile/chrome/
    fi
  '';
  
  home.activation = {
    zenSetup = ''
      mkdir -p ~/.config/zen/c2tfi4s0.Default\ Profile/chrome

      ln -sf ~/.local/state/caelestia/theme/zenChrome.css \
        ~/.config/zen/c2tfi4s0.Default\ Profile/chrome/userChrome.css

      ln -sf ~/.local/state/caelestia/theme/zenContent.css \
        ~/.config/zen/c2tfi4s0.Default\ Profile/chrome/userContent.css
    '';

    caelestiaState = ''
      mkdir -p ~/.local/state/caelestia/theme
    '';
  };
}