{
  description = "A kitchen sink flake, showing main functionality";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs: {

    nixosConfigurations.flakeimp = inputs.nixpkgs-unstable.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../../modules/container
        ../../modules/simple
      ];
    };

  };
}
