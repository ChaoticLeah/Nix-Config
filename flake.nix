{
	description = "Flake :3";
	
	inputs = {
	        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
		
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
		#self.submodules = true;
	};
	

	outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs: {
	
		commonModules = [
			inputs.nixvim.nixosModules.nixvim
			inputs.home-manager.nixosModules.home-manager
			({ config, ...} : {
				home-manager.extraSpecialArgs = {
					inherit (config.networking) hostName;
				};
			})

            ({ config, ...}: {
                home-manager.extraSpecialArgs = {
                  inherit (config.networking) hostName;
                };
            })

            inputs.sops-nix.nixosModules.sops
			#./modules/common.nix
		];
		
		nixosConfigurations = {
			hyprleah = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = self.commonModules ++ [
					./hosts/leah/config.nix
					({ ... }: {
						networking.hostName = "hyprleah";
					})
				];
            };

			smolleah = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; inherit nixpkgs-stable; };
				modules = self.commonModules ++ [
					./hosts/smolleah/config.nix
					({ ... }: {
						networking.hostName = "smolleah";
					})
				];

			};
		};

	};
}
