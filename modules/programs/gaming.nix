{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winetricks

    mangohud
    
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

  systemd.settings.Manager = {
    DefaultLimitNOFILE = 524288;
  };
  
  security.pam.loginLimits = [{
    domain = "isaac";
    type = "hard";
    item = "nofile";
    value = "524288";
  }];
}
