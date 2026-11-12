{ pkgs, ... }: {
  home.packages = with pkgs; [
    jetbrains-toolbox
    jetbrains.rider

    zed-editor
    opencode
    cloc
    foot
  ];
}
