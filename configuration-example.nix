# Top-level module.
# See https://nixos.org/nixos/manual/#sec-writing-modules
{ config, pkgs, ... }:

let
  overlay-mine = (import ./overlays);

  # https://github.com/nix-community/emacs-overlay/commits/master
  overlay-emacs = (import (fetchGit {
    url = "https://github.com/nix-community/emacs-overlay";
    ref = "master";
    rev = "7a9694ef831a848fd423bbbd60e807b236647bb8";
  }));

  # https://github.com/nix-community/emacs-overlay/commits/master
  overlay-wayland = (import (fetchGit {
    url = "https://github.com/colemickens/nixpkgs-wayland";
    ref = "master";
    rev = "724ac75779a1d411e89ebe0ab4aab721e0af525b";
  }));

  pkgs = (import (fetchGit {
    url = "https://github.com/NixOS/nixpkgs-channels";
    ref = "nixpkgs-20.03-darwin";

    # If `rev` is assigned a value, the channel will be pinned to this revision.
    # If not, the latest commit relative to the `ref` above will be used.
    rev = "02203c195495aeb5fa1eeffea6cfa8a291de05a8";
  }) { overlays = [ overlay-emacs overlay-wayland overlay-mine ]; });

  secrets = (import ./secrets.nix);
in {
  imports = [
    (import ./roles/darwin-laptop { inherit pkgs; })
    (import ./users/joe.nix { inherit pkgs secrets; })
  ];

  inherit (secrets) users;
}
