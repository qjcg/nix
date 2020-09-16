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
    rev = "6ab6350e595dec2c08778b6cb1d3ed2dcfeaa4e4";
  });

  # https://github.com/colemickens/nixpkgs-wayland/commits/master
  overlay-wayland = import (fetchGit {
    url = "https://github.com/colemickens/nixpkgs-wayland";
    ref = "master";
    rev = "762f7955bcbe16d2c8d0a11843240dca5ec30ede";
  });

  # https://github.com/NixOS/nixpkgs-channels/commits/nixos-unstable
  pkgs = import (fetchGit {
    url = "https://github.com/NixOS/nixpkgs-channels";
    ref = "nixos-unstable";
    rev = "1c10ce66c5a19c766f0da7a8ee43ea4b8d60662f";
  }) { overlays = [ overlay-emacs overlay-wayland overlay-mine ]; };
in {

  imports = [
    (import ./machines/luban { inherit config pkgs secrets; })

    (import ./roles/workstation-base { inherit pkgs; })
    (import ./roles/workstation-gnome { inherit pkgs; })
    (import ./roles/workstation-wayland { inherit pkgs; })

    (import ./users/john.nix { inherit pkgs secrets; })
  ];

}
