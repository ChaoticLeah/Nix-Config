{ config, pkgs, lib, ...}: 
{

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "leah";
    #environment = {
      # PublishedServerUrl = lib.mkForce "0.0.0.0";
    #};
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  users.users.leah.extraGroups = [ "video" "render" ];
  #users.users.jellyfin = {
  #  isSystemUser = true;
  #  extraGroups = [ "video" "render" ];
  #};

}
