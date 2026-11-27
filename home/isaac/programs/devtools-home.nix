{ pkgs, ... }: {
  home.packages = with pkgs; [
    jetbrains-toolbox
    jetbrains.rider

    zed-editor
    opencode
    claude-code
    cloc
    foot

    poppler-utils
  ];
}
