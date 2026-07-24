{

	description = "NixOS System Flake";

	inputs = {
		
		# Other examples of nixpkgs.url:
		#
		# nixpkgs = {
		# 	url = "github:NixOS/nixpkgs/release-26.05";
		# };
		#
		# nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";

		nixpkgs.url = "nixpkgs/release-26.05";

		home-manager.url = "github:nix-community/home-manager/release-26.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }:
		let
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
			};
		};
		homeConfigurations = {
			ollie = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix ];
			};
		};
	};

}
