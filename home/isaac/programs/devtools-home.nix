{ pkgs, ... }: {
  home.packages = with pkgs; [
    jetbrains-toolbox
    jetbrains.clion
    
    zed-editor
    opencode
    cloc
    foot
  ];
}