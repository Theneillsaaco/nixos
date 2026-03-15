{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vscode
    fastfetch

    curl
    wget
    nil
    nixd
    
    dotnet-sdk
    bun
    nodejs
    python3
  ];
}