{ pkgs, inputs, ... }:
let
  zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  home.packages = [
    zen
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
      "application/xhtml+xml" = "zen-beta.desktop";
    };
  };
}
