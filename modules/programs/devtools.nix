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
    alejandra
    
    dotnet-sdk
    bun
    nodejs
    python3
  ];
}