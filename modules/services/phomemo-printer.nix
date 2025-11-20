{ config, pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [ pkgs.phomemo-tools ];
  };

}
