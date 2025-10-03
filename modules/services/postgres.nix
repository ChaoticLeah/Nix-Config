{ config, pkgs, ...}: 
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    settings = {
        port = 5432;
    };
    ensureDatabases = [ "immich" ];
    ensureUsers = [
      {
        name = "immich";
        ensureDBOwnership = true;
      }
    ];
  };
}
