{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winetricks

    (pkgs.lutris.override {
      extraPkgs = pkgs: with pkgs; [
        zenity
        libadwaita
        winetricks
        vulkan-tools
      ];
      extraLibraries = pkgs: with pkgs; [
        libadwaita
        gtk4
      ];
    })
  ];
}
