{
  description = "A flake providing an MVP container.";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs: {

    nixosConfigurations.mvp = inputs.pkgs-unstable.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ config, pkgs, ... }: {

          boot.isContainer = true;
          networking.useDHCP = false;
          environment.systemPackages = with pkgs; [ htop ];
        })
      ];
    };

  };
}
