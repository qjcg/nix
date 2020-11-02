{
  description = "A flake providing an MVP container.";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }: {

    nixosConfigurations.mvp = inputs.pkgs.lib.nixosSystem {
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
