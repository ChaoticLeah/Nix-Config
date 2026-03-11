{
  description = "Flake :3";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    wifitui = {
      url = "github:shazow/wifitui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixos-cosmic,
      ...
    }@inputs:
    let 
      secretsFile = ./secrets.yaml;
      globals = {
        user = "leah";
        inherit secretsFile;
      };
    in
    {
      commonModules = [
        inputs.nixvim.nixosModules.nixvim
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        inputs.mango.nixosModules.mango

        (
          { config, ... }:
          {
            home-manager.extraSpecialArgs = {
              inherit (config.networking) hostName;
              inherit inputs globals;
            };

            home-manager.sharedModules = [
              inputs.sops-nix.homeManagerModules.sops
            ];
          }
        )

        #./modules/common.nix
      ];

      nixosConfigurations = {
        hyprleah = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs globals;
            inherit nixpkgs-stable;
          };
          modules = self.commonModules ++ [
            ./hosts/leah/config.nix
            (
              { ... }:
              {
                networking.hostName = "hyprleah";
              }
            )
          ];
        };

        smolleah = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs globals;
            inherit nixpkgs-stable;
          };
          modules = self.commonModules ++ [
            ./hosts/smolleah/config.nix
            (
              { ... }:
              {
                networking.hostName = "smolleah";
              }
            )
          ];
        };
        server-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs globals;
            inherit nixpkgs-stable;
          };
          modules = self.commonModules ++ [
            ./hosts/server-nixos/config.nix
            (
              { ... }:
              {
                networking.hostName = "server-nixos";
              }
            )
          ];
        };
	lyco-reco = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = self.commonModules ++ [
					./hosts/lyco-reco/config.nix
					({ ... }: {
						networking.hostName = "lyco-reco";
					})
				];
			};
      };
    };
}
