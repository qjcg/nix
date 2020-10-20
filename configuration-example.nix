# Top-level module.
# See https://nixos.org/nixos/manual/#sec-writing-modules
{ config, pkgs, ... }:

let
  secrets = import ./secrets.nix;
  overlay-mine = import ./overlays;

  # https://github.com/nix-community/emacs-overlay/commits/master
  overlay-emacs = import (fetchGit {
    url = "https://github.com/nix-community/emacs-overlay";
    ref = "master";
    rev = "aa199d5e708914d7cad2b5019b0d73d1adedb93d";
  });

  # https://github.com/colemickens/nixpkgs-wayland/commits/master
  overlay-wayland = import (fetchGit {
    url = "https://github.com/colemickens/nixpkgs-wayland";
    ref = "master";
    rev = "24d952f52170a7a2cb30920c47948ad44e85174c";
  });

  # https://github.com/NixOS/nixpkgs-channels/commits/nixos-unstable
  pkgs = import (fetchGit {
    url = "https://github.com/NixOS/nixpkgs-channels";
    ref = "nixos-unstable";
    rev = "84d74ae9c9cbed73274b8e4e00be14688ffc93fe";
  }) { overlays = [ overlay-emacs overlay-wayland overlay-mine ]; };
in {

  imports = [
    (import ./modules/machines/luban { inherit config pkgs secrets; })

    (import ./modules/roles/workstation-base { inherit pkgs; })
    (import ./modules/roles/workstation-gnome { inherit pkgs; })
    (import ./modules/roles/workstation-wayland { inherit pkgs; })

    (import ./modules/users/john.nix { inherit pkgs secrets; })
  ];

}
