{
  description = "A flake providing a module.";

  inputs = {
    pkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    let
      pkgs = inputs.pkgs-unstable.legacyPackages.x86_64-linux;
    in
    {
      nixosModules = {
        simple = import ./my_module.nix { inherit pkgs; };
      };

      nixosConfigurations.flake = inputs.pkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.simple

          ({ config, pkgs, ... }: {

            boot.isContainer = true;
            networking.hostName = "nixos-from-flake";
            networking.useDHCP = false;
          })
        ];
      };

    };
}
