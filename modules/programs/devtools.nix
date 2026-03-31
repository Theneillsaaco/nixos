{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    vscode
    fastfetch

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
  ];
}