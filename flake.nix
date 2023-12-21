{
  description = "Nix Infrastructure";
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    # Unmodified nixpkgs
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  in {
    homeConfigurations = {
      "nic" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = {
          inherit inputs;
        }; # Pass flake inputs to our config
        #  Our main home-manager configuration file <
        modules = [
          ./home-manager
          {
            home = {
              username = "nic";
              homeDirectory = "/home/nic";
            };
          }
        ];
      };
    };
  };
}