{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vscode
    fastfetch

    cloudflared
    curl
    wget
    nil
    nixd
    alejandra
    
    dotnet-sdk_10
    bun
    nodejs
    python3
    
    arduino-ide
    arduino-cli
    screen

    gcc
    cmake
    ninja
    pkg-config
    
    lua
    lua5_5
    
    qt6.qtbase
    qt6.wrapQtAppsHook
    qt6.qtdeclarative
  ];
}