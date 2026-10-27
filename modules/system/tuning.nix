{
  services.fstrim.enable = true;

  programs.command-not-found.enable = false;

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.settings.Manager.DefaultTimeoutStopSec = "30s";
}