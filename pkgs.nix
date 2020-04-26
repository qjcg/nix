# This file specifies **pinned versions** of nixpkgs and other overlays.
# It should be imported and passed down to other modules via configuration.nix.

let
  # nixpkgs-unstable
  # https://github.com/NixOS/nixpkgs/branches/all
  # https://github.com/NixOS/nixpkgs/tree/nixos-unstable
  # https://github.com/NixOS/nixpkgs/tree/nixpkgs-unstable
  ref-nixpkgs = "9b0d2f3fd153167b0c8ce84bb71e766a39ed4c9d";

  # nixpkgs-wayland
  # https://github.com/colemickens/nixpkgs-wayland/branches/all
  ref-wayland = "2fc9c014772551a6c5fe64839dfd7e4e60b24d2e";
in

(import (builtins.fetchTarball {
  name = "nixpkgs-unstable";
  url = "https://github.com/NixOS/nixpkgs/archive/${ref-nixpkgs}.tar.gz";
}) {

  overlays = [
    (import ./overlays)
    (import ./overlays/st)
    (import ./overlays/sxiv)
    (import ./overlays/environments.nix)
    #(import ./overlays/neovim)

    (import (builtins.fetchTarball {
      name = "nixpkgs-wayland";
      url = "https://github.com/colemickens/nixpkgs-wayland/archive/${ref-wayland}.tar.gz";
    }))
  ];

})
