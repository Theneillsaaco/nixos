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
    
    cmake
    ninja
    pkg-config
    lua
    qt6.qtbase
    qt6.qtdeclarative
  ];
}