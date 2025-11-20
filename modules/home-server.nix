{ config, pkgs, inputs, ... }:
{

  imports = [
    ./services/sops.nix
    ./services/tailscale.nix
    ./development/git.nix	
    ./services/immich.nix
    ./services/jellyfin.nix
    ./services/cloudflare.nix
  ];

  services.cloudflared.enable = true;
  
  services.immich.mediaLocation = "/mnt/data/immich";
  services.jellyfin.dataDir = "/mnt/data/jellyfin/data";

  services.cloudflareTunnels.enable = true;
  services.cloudflareTunnels.immich.enable = true;
}
