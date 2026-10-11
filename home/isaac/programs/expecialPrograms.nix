{ pkgs, inputs, ... }: {
  home.packages = [
    (pkgs.obsidian.override {
      commandLineArgs = [
        "--password-store=kwallet6"
      ];
    })

    inputs.media-player.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}