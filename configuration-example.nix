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
        rev = "28eb093a1e6999d52e60811008b4bfc7e20cc591";
      }
    }/nixos";

  # https://github.com/nix-community/emacs-overlay/commits/master
  overlay-emacs = import (fetchGit {
    url = "https://github.com/nix-community/emacs-overlay";
    ref = "master";
    rev = "a69588a3f7de6d68f20cea21562ab7f6f91a400a";
  });

  # https://github.com/colemickens/nixpkgs-wayland/commits/master
  overlay-wayland = import (fetchGit {
    url = "https://github.com/colemickens/nixpkgs-wayland";
    ref = "master";
    rev = "cf33b87dafc85c8884b75daab30797355c6e7251";
  });

  # https://github.com/NixOS/nixpkgs/commits/nixos-unstable
  pkgs = import
    (fetchGit {
      url = "https://github.com/NixOS/nixpkgs";
      ref = "nixos-unstable";
      rev = "9085a724fdd7668f6e59abd9dfc7aef4e1dde3dd";
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
