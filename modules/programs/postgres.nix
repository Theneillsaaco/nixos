{ pkgs, lib, ... }: {
  services.postgresql = {
    enable = false;
    package = pkgs.postgresql_18;

    ensureDatabases = [ "isaac" ];
    ensureUsers = [
      {
        name = "isaac";
        ensureClauses.superuser = true;
      }
    ];
    
    authentication = lib.mkOverride 10 ''
      # TYPE  DATABASE  USER  ADDRESS         METHOD
      local   all       all                   peer
      host    all       all   127.0.0.1/32    scram-sha-256
      host    all       all   ::1/128         scram-sha-256
    '';
  };

  systemd.services.postgresql.wantedBy = lib.mkForce [ ];
}
