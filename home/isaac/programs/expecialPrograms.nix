{ pkgs, ... }: {
  home.packages = [
    (pkgs.obsidian.override {
      commandLineArgs = [
        "--password-store=kwallet6"
      ];
    })
  ];
}