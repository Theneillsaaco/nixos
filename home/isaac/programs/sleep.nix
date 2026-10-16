{ pkgs, hostName, ... }: 
let 
  mode = if hostName == "lenovo" then "suspend-then-hibernate" else "suspend";
in {
  home.packages = [
    (pkgs.writeShellScriptBin "sleep-now" "exec systemctl ${mode}")
  ];
}
