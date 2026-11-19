{ pkgs, inputs, ... }: {
  home.packages = [
    (pkgs.obsidian.override {
      commandLineArgs = [
        "--password-store=kwallet6"
      ];
    })

    inputs.kyuto.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.ktabletop.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.app-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.mocktail.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}