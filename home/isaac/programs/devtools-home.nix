{ pkgs, ... }: {
  home.packages = with pkgs; [
    jetbrains-toolbox
    zed-editor
    opencode
    cloc
  ];
}