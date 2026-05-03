{ pkgs, ... }: 

let
  caelestiafox = pkgs.writeShellScriptBin "caelestiafox" ''
    ${pkgs.fish}/bin/fish <<'EOF'
    function message -a msg
        set -l x (printf '%08X' (string length -- $msg))
        printf '%b' "\\x$(string sub -s 7 -l 2 $x)\\x$(string sub -s 5 -l 2 $x)\\x$(string sub -s 3 -l 2 $x)\\x$(string sub -s 1 -l 2 $x)"
        printf '%s' $msg
    end

    set -q XDG_STATE_HOME && set -l state $XDG_STATE_HOME || set -l state $HOME/.local/state
    set -l state_dir $state/caelestia
    set -l scheme_path $state_dir/scheme.json

    if test -f $scheme_path
        message (jq -c . $scheme_path)
    else
        message "{}"
    end

    inotifywait -q -e 'close_write,moved_to,create' -m $state_dir | while read dir events file
        test "$dir$file" = $scheme_path && message (jq -c . $scheme_path)
    end
    EOF
  '';
in {
  programs.zen-browser.enable = true;
 
   home.packages = with pkgs; [
     fish
     jq
     inotify-tools
     caelestiafox
   ];
 
   # Native messaging
   home.file.".mozilla/native-messaging-hosts/caelestiafox.json".text = ''
   {
     "name": "caelestiafox",
     "description": "Native app for CaelestiaFox extension.",
     "path": "${caelestiafox}/bin/caelestiafox",
     "type": "stdio",
     "allowed_extensions": ["caelestiafox@caelestia.org"]
   }
   '';
 
   # USERCHROME
   home.file.".config/zen/c2tfi4s0.Default Profile/chrome/userChrome.css".source = ./userChrome.css;
 
   home.activation.createZenChromeDir = ''
     mkdir -p ~/.config/zen/c2tfi4s0.Default\ Profile/chrome
   '';
 
   # Crear scheme.json
   home.activation.createCaelestiaState = ''
     mkdir -p ~/.local/state/caelestia
     [ -f ~/.local/state/caelestia/scheme.json ] || echo '{}' > ~/.local/state/caelestia/scheme.json
   '';
}