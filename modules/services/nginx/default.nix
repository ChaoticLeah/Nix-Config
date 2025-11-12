{ config, pkgs, lib, ... }:

let
  nginxDir = builtins.toString ./.;

  siteFiles = if builtins.pathExists nginxDir then
                lib.filter (f: lib.hasSuffix ".nix" f && f != "default.nix") (builtins.attrNames (builtins.readDir nginxDir))
              else [];

  siteModules = map (f: import (nginxDir + "/" + f) { inherit config pkgs lib; }) siteFiles;

  virtualHosts = if siteModules == [] then {}
                 else lib.attrsets.mergeAttrsList (map (m: if m ? virtualHosts then m.virtualHosts else {}) siteModules);
in
{
  services.nginx = {
    enable = true;

    # Merge virtual hosts from all site modules
    virtualHosts = virtualHosts;

    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "leah@leahdevs.xyz";
  };
}

