{ config, pkgs, ... }:
{
  sops = {
    age.keyFile = "/etc/age/keys.txt";
    defaultSopsFile = ../secrets.yaml;
  };
}
