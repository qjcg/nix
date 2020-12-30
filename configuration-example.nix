# Top-level module.
# See https://nixos.org/nixos/manual/#sec-writing-modules
{ config, pkgs, ... }:
let
  secrets = import ./secrets.nix;
  overlay-mine = import ./packages;

  # https://github.com/nix-community/home-manager/commits/master
  home-manager = import "${
      fetchGit {
        url = "https://github.com/nix-community/home-manager";
        ref = "master";
        rev = "8e0c1c55fbb7f16f9fd313275ddf63c97b34394c";
      }
    }/nixos";

  # https://github.com/nix-community/emacs-overlay/commits/master
  overlay-emacs = import (fetchGit {
    url = "https://github.com/nix-community/emacs-overlay";
    ref = "master";
    rev = "05fb17fc6ef2b1c205a034b7aabbc463291a0fcb";
  });

  # https://github.com/colemickens/nixpkgs-wayland/commits/master
  overlay-wayland = import (fetchGit {
    url = "https://github.com/colemickens/nixpkgs-wayland";
    ref = "master";
    rev = "f472abb3b7cf5d620f738f0c4e66d1d2d67e2641";
  });

  # https://github.com/NixOS/nixpkgs/commits/nixos-unstable
  pkgs = import
    (fetchGit {
      url = "https://github.com/NixOS/nixpkgs";
      ref = "nixos-unstable";
      rev = "733e537a8ad76fd355b6f501127f7d0eb8861775";
    })
    { overlays = [ overlay-emacs overlay-wayland overlay-mine ]; };
in
{
  nixpkgs.config.allowBroken = false;

  imports = [
    (import ./modules/machines/luban { inherit config pkgs secrets; })
    (import ./modules/roles/workstation-base { inherit config pkgs; })
    (import ./modules/roles/workstation-gnome { inherit config pkgs; })
    (import ./modules/roles/workstation-wayland { inherit config pkgs; })
    (import ./modules/users/john.nix {
      inherit config home-manager pkgs secrets;
    })
  ];

}
