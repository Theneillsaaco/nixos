{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    git
    vscode
    fastfetch
    jetbrains-toolbox

    curl
    wget

  ];
}