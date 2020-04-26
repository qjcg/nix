# This file specifies **pinned versions** of nixpkgs and other overlays.
# It should be imported and passed down to other modules via configuration.nix.

let
  # nixos / nixpkgs-unstable
  # https://github.com/NixOS/nixpkgs/branches/all
  # https://github.com/NixOS/nixpkgs/tree/nixos-unstable
  # https://github.com/NixOS/nixpkgs/tree/nixpkgs-unstable
  ref-nixpkgs = "22a3bf9fb9edad917fb6cd1066d58b5e426ee975"; # nixos-unstable branch

  # nixpkgs-wayland
  # https://github.com/colemickens/nixpkgs-wayland/branches/all
  ref-wayland = "724ac75779a1d411e89ebe0ab4aab721e0af525b";
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
