# See https://www.tweag.io/blog/2020-07-31-nixos-flakes/
{
  description = "A flake for my nix configurations";

  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
    pkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-20.03-darwin";
    pkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home.url = "github:rycee/home-manager/bqv-flakes";
    wayland.url = "github:colemickens/nixpkgs-wayland";
  };

  outputs = { self, pkgs, pkgs-darwin, pkgs-unstable, home, wayland }:

    let
      secrets = import ./secrets.nix;

      # Overlays, see https://nixos.wiki/wiki/Flakes#Importing_packages_from_multiple_channels
      myOverlay = final: prev: {
        home = home.legacyPackages."x86_64-linux";
        unstable = pkgs-unstable.legacyPackages."x86_64-linux";
        wayland = wayland.legacyPackages."x86_64-linux";
      };
    in {
      nixosConfigurations.luban = pkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ myOverlay ];
            imports = [
              (import ./machines/luban { inherit config pkgs secrets; })

              (import ./roles/workstation-base { inherit pkgs; })
              (import ./roles/workstation-gnome { inherit pkgs; })
              (import ./roles/workstation-wayland { inherit pkgs; })

              (import ./users/john.nix { inherit pkgs secrets; })
            ];
          })
        ];
      };
    };
}
