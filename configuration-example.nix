{ config, pkgs, ... }:

let
  pkgs = import <nixpkgs> {
    overlays = [
      (import ./packages)

      # TODO: Clearly distinguish/separate overlays (below) from packages.
      (import ./packages/neovim)
      (import ./packages/st)
      (import ./packages/sxiv)
      (import ./packages/vscodium-with-extensions)

      (import ./packages/overrides.nix)
      (import ./packages/environments.nix)
    ];
  };

  secrets = import ./secrets.nix ;
in
{

  imports = [
    ./machines/luban
    ./roles/gnome-workstation
    ./roles/wayfire-workstation
    (import ./users/john.nix { inherit config pkgs secrets; })
  ];

  nixpkgs.config.allowUnfree = true;

}
