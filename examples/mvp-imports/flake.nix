{
  description = "A flake providing an MVP container via module imports.";

  inputs.pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, ... }@inputs: {

    nixosConfigurations.mvp-imports = inputs.pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../../modules/container.nix
        ../../modules/simple.nix
      ];
    };

  };
}
