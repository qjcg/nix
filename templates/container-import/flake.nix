{
  description = "A flake providing a NixOS system container MVP via module imports.";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs: {

    nixosConfigurations.flakeimp = inputs.pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../../modules/container.nix
        ../../modules/simple.nix
      ];
    };

  };
}
