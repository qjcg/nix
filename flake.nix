# See https://www.tweag.io/blog/2020-07-31-nixos-flakes/
{
  description = "A flake for my nix configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-20.03-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    wayland.url = "github:colemickens/nixpkgs-wayland";
  };

  outputs = { self, nixpkgs, nixpkgs-darwin, nixpkgs-unstable, wayland }: {

    nixosConfigurations.luban = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };

  };

}
