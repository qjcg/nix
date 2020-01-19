{ config, pkgs, lib, ... }:

{

  imports = [
    ../../roles/rpi3
    ../../users/john.nix
  ];

  networking.hostName = "rpi3";

}
