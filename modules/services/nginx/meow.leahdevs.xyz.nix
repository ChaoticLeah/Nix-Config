{ config, pkgs, lib, ... }:
{
  virtualHosts."meow.leahdevs.xyz" = {
    enableACME = true;       # request Let's Encrypt certificate
    forceSSL = true;         # redirect HTTP → HTTPS

    # The web root is not needed for proxy, but Nginx requires a root
    root = "/var/www/meow";

    locations."/" = {
      # Proxy to GoToSocial
      proxyPass = "http://0.0.0.0:8080";

      # Recommended proxy settings
      recommendedProxySettings = true;
      proxyWebsockets = true;
    };
  };
}
