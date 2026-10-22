{ pkgs, inputs, ... }: {
  home.packages = [
    (pkgs.obsidian.override {
      commandLineArgs = [
        "--password-store=kwallet6"
      ];
    })

    inputs.media-player.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.ktabletop.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.app-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}