# A simple example module that adds a systemPackage.
{ config, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [ hello ];
  };
}
