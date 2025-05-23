{
  description = "leah's flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
        specialArgs = { inherit pkgs-unstable; };
      };
    };
  };
}
