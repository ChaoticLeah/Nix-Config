{
  config,
  pkgs,
  lib,
  ...
}:
{
  virtualHosts."games.leahdevs.xyz" = {
    enableACME = true; # request Let's Encrypt certificate
    forceSSL = true; # redirect HTTP → HTTPS

    # Nginx still requires a root even if proxying
    root = "/var/www/pufferpanel";

    locations."/" = {
      proxyPass = "http://127.0.0.1:8085";

      # Recommended proxy settings
      recommendedProxySettings = true;
      proxyWebsockets = true;

      # Extra options not covered by recommended settings
      extraConfig = ''
        proxy_connect_timeout 60s;
        proxy_read_timeout 60s;
        proxy_send_timeout 60s;

        # Handle upgrade headers for websockets
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Nginx-Proxy true;
      '';
    };

    # Optional: allow ACME challenge through /.well-known
    locations."/.well-known" = {
      root = "/var/www/html";
      extraConfig = ''
        allow all;
      '';
    };
  };
}
