{ pkgs, config, ... }:

{
  services.syncthing = {
    enable = true;
    #openDefaultPorts = true;

    settings = {
      devices = {
        "leahs-syncthing" = { 
          id = "7QIB32T-BC76N53-A2SLPH3-7UXWICB-IFNSRO7-RBKELD3-T3YU52C-ZWPU3Q7";
          addresses = [ "tcp://192.168.2.36:8384" ];
        };
      };

      folders = {
        "default" = {
          id = "default";
          path = "${config.home.homeDirectory}/documents/data";
          devices = [ "leahs-syncthing" ];
        };

        "zjpmo-auc3r" = {
          id = "zjpmo-auc3r";
          path = "${config.home.homeDirectory}/documents/vaults";
          devices = [ "leahs-syncthing" ];
        };
      };
    };
  };
}

