{ lib, ... }: {
  # snapshots
  services.snapper = {
    configs = {
      root = {
        SUBVOLUME = "/";
        # activa o desactiva las snapshots
        TIMELINE_CREATE = false;
        TIMELINE_CLEANUP = true;
        NUMBER_CLEANUP = true;
        NUMBER_LIMIT = 10;
        NUMBER_LIMIT_IMPORTANT = 5;
      };
      home = {
        SUBVOLUME = "/home";
        # activa o desactiva las snapshots
        TIMELINE_CREATE = false;
        TIMELINE_CLEANUP = true;
        NUMBER_CLEANUP = true;
        NUMBER_LIMIT = 10;
        NUMBER_LIMIT_IMPORTANT = 5;
      };
    };
  };
  
  # btrfs config
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
  
  # Moding 
  fileSystems."/" .options = 
    lib.mkAfter  [ "compress=zstd" "noatime" ];

  fileSystems."/home" .options = 
    lib.mkAfter [ "compress=zstd" "noatime" ];
}