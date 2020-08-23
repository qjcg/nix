# See https://www.tweag.io/blog/2020-07-31-nixos-flakes/
{
  description = "A flake for my nix configurations";

  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
    pkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-20.03-darwin";
    pkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    wayland.url = "github:colemickens/nixpkgs-wayland";
  };

  outputs = { self, pkgs, pkgs-darwin, pkgs-unstable, wayland }:

    let
      # Overlays, see https://nixos.wiki/wiki/Flakes#Importing_packages_from_multiple_channels
      overlay-unstable = final: prev: {
        unstable = pkgs-unstable.legacyPackages."x86_64-linux";
      };

      overlay-wayland = final: prev: {
        wayland = wayland.legacyPackages."x86_64-linux";
      };
    in {
      nixosConfigurations.luban = pkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ overlay-unstable overlay-wayland ];
          })
        ];
      };
    };
}
