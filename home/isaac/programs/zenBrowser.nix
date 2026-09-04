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
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
      "application/xhtml+xml" = "zen.desktop";
    };
  };
}