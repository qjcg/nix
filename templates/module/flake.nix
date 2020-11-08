{
  description = "A flake providing a module.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    {
      nixosModules = {
        hello = import ./modules/hello.nix;
      };

      # A container provided to verify that the module we define above is
      # working as expected.
      nixosConfigurations.flake = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.hello

          ({ config, pkgs, ... }: {

            boot.isContainer = true;
            networking.hostName = "nixos-from-flake";
            networking.useDHCP = false;

            # Here we set the hello role to enabled.
            # This will result in the "hello" package being installed when the
            # container is created.
            roles.hello.enable = true;
          })
        ];
      };

    };
}
