{
	description = "Flake :3";
	
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, ... }@inputs: {
	
		commonModules = [
			inputs.home-manager.nixosModules.home-manager
			({ config, ...} : {
				home-manager.extraSpecialArgs = {
					inherit (config.networking) hostName;
				};
			})

			./modules/common.nix
		];
		
		nixosConfigurations = {
			leah = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = self.commonModules ++ [
					./hosts/leah/config.nix
					({ ... }: {
						networking.hostName = "hyprleah";
					})
				];
			};
		};

	};
}
