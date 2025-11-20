{
  config,
  pkgs,
  lib,
  ...
}:
{
  virtualHosts."search.leahdevs.xyz" = {
    enableACME = true; # request Let's Encrypt certificate
    forceSSL = true; # redirect HTTP → HTTPS

    # The web root is not needed for proxy, but Nginx requires a root
    root = "/var/www/search";
    #sslCertificate = "...";
    #sslCertificateKey = "...";
    locations = {
      "/" = {
        proxyPass = "http://0.0.0.0:9081";
        # Recommended proxy settings
        recommendedProxySettings = true;
        proxyWebsockets = true;

        #extraConfig = ''
        #  uwsgi_pass unix:${config.services.searx.uwsgiConfig.socket};
        #'';
      };
    };
  };
}
