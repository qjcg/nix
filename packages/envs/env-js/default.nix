{ pkgs, nodePackages, ... }:

with pkgs;

buildEnv {
  name = "env-js";
  paths = [
    nodejs-16_x
    nodePackages.node2nix
  ];
  meta = {
    description = "An environment for JS development";
    priority = 0;
  };
}
