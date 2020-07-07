# Top-level module.
# See https://nixos.org/nixos/manual/#sec-writing-modules
{ config, lib, pkgs, ... }:

let
  secrets = import ./secrets.nix;
  overlay-mine = import ./overlays;

  # https://github.com/nix-community/emacs-overlay/commits/master
  overlay-emacs = import (fetchGit {
    url = "https://github.com/nix-community/emacs-overlay";
    ref = "master";
    rev = "4838aeeab959711120f8901b3fcda391f39f4e9b";
  });

  # https://github.com/colemickens/nixpkgs-wayland/commits/master
  overlay-wayland = import (fetchGit {
    url = "https://github.com/colemickens/nixpkgs-wayland";
    ref = "master";
    rev = "81c6c3601b80cfdd5b9af24db3065023c77a2e36";
  });

  pkgs = import (fetchGit {
    url = "https://github.com/NixOS/nixpkgs-channels";
    ref = "nixos-20.03";

    # If `rev` is assigned a value, the channel will be pinned to this revision.
    # If not, the latest commit relative to the `ref` above will be used.
    rev = "c9d124e39dbeefc53c7b3e09fbfc2c26bcbd4845";
    #}) { overlays = [ overlay-emacs overlay-wayland overlay-mine ]; };
  }) { overlays = [ overlay-emacs overlay-wayland overlay-mine ]; };
in {

  imports = [
    (import ./machines/luban { inherit config pkgs secrets; })

    (import ./roles/gnome-workstation { inherit pkgs; })
    (import ./roles/wayland { inherit pkgs; })

    (import ./users/john.nix { inherit lib pkgs secrets; })
  ];

}
