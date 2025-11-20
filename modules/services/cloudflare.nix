{ config, lib, pkgs, ... }:

let
  cfg = config.services.cloudflareTunnels;
in
{
  options.services.cloudflareTunnels = {
    enable = lib.mkEnableOption "Cloudflare tunnels module";

    immich.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Cloudflare tunnel for Immich.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.cloudflared.enable = true;

    services.cloudflared.tunnels =
      lib.mkMerge [
        (lib.mkIf cfg.immich.enable {
          immich = {
            credentialsFile = "/home/leah/.cloudflared/459c4b4c-3218-46a3-82ca-5dfcd4eb1b77.json";

            default = "http_status:404";

            ingress = {
              "photos.leahdevs.xyz" = "http://localhost:2283";
              "default" = "http_status:404";
            };
          };
        })
      ];
  };
}

