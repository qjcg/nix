{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import ../../packages)
  ];

  environment.systemPackages = with pkgs; [
    emacs
  ];
}
