{ config, pkgs, ...}: 
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    port = 5433;  # system postgres runs here
    ensureDatabases = [ "immich" ];
    ensureUsers = [
      {
        name = "immich";
        ensureDBOwnership = true;
      }
    ];
  };
}
