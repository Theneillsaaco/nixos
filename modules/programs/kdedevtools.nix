{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kdePackages.extra-cmake-modules
    kdePackages.kcoreaddons
    kdePackages.ki18n
    kdePackages.kxmlgui
  ];
}