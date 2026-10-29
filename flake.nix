{

  description = "NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.2.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      claude-code,
      lanzaboote,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ claude-code.overlays.default ];
      };
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ ./system/configuration.nix
                      lanzaboote.nixosModules.lanzaboote
                    ];
        };
      };
      homeConfigurations = {
        ollie = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./user/home.nix ];
        };
      };
    };

}
