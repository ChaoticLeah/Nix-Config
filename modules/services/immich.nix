{ config, pkgs, lib, ... }:
{
  services.immich = {
    enable = true;
    openFirewall = true;

    environment = {
      IMMICH_HOST = lib.mkForce "0.0.0.0";
    };

    machine-learning = {
      enable = true;
      environment = {
        HF_XET_CACHE = "/var/cache/immich/huggingface-xet";
      };
    };
  };

  users.users.immich = {
    home = "/var/lib/immich";
    createHome = true;
  };
}
