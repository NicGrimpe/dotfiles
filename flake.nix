{
  description = "Nic Infrastructure";
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    home-manager,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nic-home = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
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
}