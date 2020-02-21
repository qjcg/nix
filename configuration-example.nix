{ config, pkgs, ... }:

let
  secrets = import ./secrets.nix;
in
{

  imports = [
    ./machines/luban

    ./roles/gnome-workstation
    ./roles/wayfire-workstation

    (import ./users/john.nix { inherit config secrets; })
  ];

}
