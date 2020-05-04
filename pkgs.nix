# This file specifies **pinned versions** of nixpkgs and other overlays.
# It should be imported and passed down to other modules via configuration.nix.

let
  # nixos / nixpkgs-unstable
  # https://github.com/NixOS/nixpkgs/branches/all
  # https://github.com/NixOS/nixpkgs/tree/nixos-unstable
  # https://github.com/NixOS/nixpkgs/tree/nixpkgs-unstable
  ref-nixpkgs = "fce7562cf46727fdaf801b232116bc9ce0512049"; # nixos-unstable branch

  # nixpkgs-wayland
  # https://github.com/colemickens/nixpkgs-wayland/branches/all
  ref-wayland = "724ac75779a1d411e89ebe0ab4aab721e0af525b";

  # emacs overlay
  # https://github.com/nix-community/emacs-overlay/commits/master
  ref-emacs = "7a9694ef831a848fd423bbbd60e807b236647bb8";
in

(import (builtins.fetchTarball {
  name = "nixos-unstable";
  url = "https://github.com/NixOS/nixpkgs/archive/${ref-nixpkgs}.tar.gz";
}) {

  overlays = [
    (import ./overlays)
    (import ./overlays/st)
    (import ./overlays/sxiv)
    (import ./overlays/environments.nix)
    (import ./overlays/neovim)

    (import (builtins.fetchTarball {
      name = "nixpkgs-wayland";
      url = "https://github.com/colemickens/nixpkgs-wayland/archive/${ref-wayland}.tar.gz";
    }))
  ];

})
