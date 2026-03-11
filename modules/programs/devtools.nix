{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vscode
    fastfetch

    curl
    wget
    dotnet-sdk

    bun
    nodejs
  ];
}