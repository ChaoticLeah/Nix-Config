{ config, pkgs, ...}: 
let
  secretsFile = "/etc/nixos/secrets.yaml";
  ageKeyFile = "/etc/age/keys.txt";
in
{
  services.immich = {
    enable = true;
    port = 2283;
    database.create = false; # don’t spawn own postgres
    redis.create = false;    # don’t spawn own redis
    environment = {
      SOPS_AGE_KEY_FILE = ageKeyFile;
      IMMICH_DB_URL = "$(${pkgs.sops}/bin/sops -d --output-type json ${secretsFile} | ${pkgs.jq}/bin/jq -r .immich_db_url)";
    };
  };
}
