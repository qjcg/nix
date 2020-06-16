# Top-level module.
# See https://nixos.org/nixos/manual/#sec-writing-modules
{ config, lib, pkgs, ... }:

let
  pkgs = import ./pkgs.nix;
  secrets = import ./secrets.nix;
in {

  imports = [
    (import ./machines/luban { inherit config pkgs secrets; })

    (import ./roles/gnome-workstation { inherit pkgs; })
    (import ./roles/wayfire-workstation { inherit pkgs; })

    (import ./users/joe.nix { inherit pkgs secrets; })
  ];

}
