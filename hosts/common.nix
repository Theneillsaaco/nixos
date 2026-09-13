{ ... }: {
    nixpkgs.config.allowUnfree = true;

    programs.zsh.enable = true;
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
    programs.gamemode.enable = true;

    services.flatpak.enable = true;

    environment.variables.NIXOS_OZONE_WL = "1";
}