{ pkgs, ... }: {
  home.packages = [ pkgs.trash-cli ];

  systemd.user.services.clean-trash = {
    Unit = {
      Description = "Trash clean Service";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.trash-cli}/bin/trash-empty 30";
    };
  };

  systemd.user.timers.clean-trash = {
    Unit = {
      Description = "Daily trash clean service";
    };
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}