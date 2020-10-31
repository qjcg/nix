{
  description = "A flake providing an MVP container.";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }: {

    nixosConfigurations.mvp = pkgs.lib.nixosSystem {
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
