{ config, pkgs, globals, ... }:
{
  sops = {
    age.keyFile = "/etc/age/keys.txt";
    defaultSopsFile = globals.secretsFile;
  };
}
