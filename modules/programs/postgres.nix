{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE    USER        METHOD
      local   all         all         trust
    '';
  };
}