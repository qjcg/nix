{
  description = "A flake providing a NixOS system container.";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    {
      nixosConfigurations.flake = inputs.unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: {

            boot.isContainer = true;
            networking.hostName = "nixos-from-flake";
            networking.useDHCP = false;
            environment.systemPackages = with pkgs; [ htop ];
          })
        ];
      };
    };
}
