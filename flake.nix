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
      url = "gitlab:ChaoticLeah/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      ...
    }@inputs:
    let 
      globals = {
        user = "leah";
      };
    in
    {
      commonModules = [
        inputs.nixvim.nixosModules.nixvim
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops

        (
          { config, ... }:
          {
            home-manager.extraSpecialArgs = {
              inherit (config.networking) hostName;
              sopsFile = "/etc/nixos/secrets.yaml";
              inherit inputs globals;
            };
          }
        )

        #./modules/common.nix
      ];

      nixosConfigurations = {
        hyprleah = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs globals; };
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
      };
    };
}
