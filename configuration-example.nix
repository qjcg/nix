{ config, pkgs, ... }:

{
  # Replace the imports below with those for the local configuration.
  imports = [
    ./machines/luban
    ./roles/gnome-workstation
    ./users/john.nix
  ];
}
