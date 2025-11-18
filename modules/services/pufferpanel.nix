{ pkgs, lib, config, ... }:
{
  systemd.services.pufferpanel.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "pufferpanel";
    Group = "pufferpanel";
  };

  
  users.users.pufferpanel = {
    isSystemUser = true;
    group = "pufferpanel";
    home = "/var/lib/pufferpanel";
    # Optional: make sure the directory exists
    createHome = true;
  };

  users.groups.pufferpanel = {};

  services.pufferpanel = {
    enable = true;
    environment = {
      PUFFER_WEB_HOST = ":8085";
      PUFFER_DAEMON_SFTP_HOST = ":5657";
      PUFFER_DAEMON_CONSOLE_BUFFER = "1000";
      PUFFER_DAEMON_CONSOLE_FORWARD = "true";
      PUFFER_PANEL_REGISTRATIONENABLED = "false";
      PUFFER_DAEMON_HOST = "159.69.192.46";
      #PATH = "${pkgs.openjdk17}/bin:${pkgs.coreutils}/bin:${pkgs.bash}/bin";
      #PUFFER_PANEL_DATABASE_DIALECT = "sqlite3";
      #PUFFER_PANEL_DATABASE_URL = "file:/var/lib/pufferpanel/database.db?cache=shared";
      #PUFFER_PANEL_DATABASE_LOG = "true";
    };

    extraPackages = with pkgs; [ 
      nix-ld
      coreutils
      #openjdk17
      #openjdk21
      openjdk25
    ];
      
      
  };

  # volumes = [
  #   "/home/leah/pufferpanel/data:/var/lib/pufferpanel:rw"
  #   "/home/leah/pufferpanel/logs:/etc/pufferpanel:rw"
  #   "/var/run/docker.sock:/var/run/docker.sock:rw"
  #  ];
  #  ports = [
  #   "8085:8080/tcp"
  #    "5657:5657/tcp"
  #    "27015:27015/tcp"
  #    "25565:25565/tcp"
  #  ];
}
