{ config, pkgs, ... }:

{
  imports = [
    (import ./configuration.nix { inherit config pkgs; })
    ./hardware-configuration.nix
  ];
}
