{ pkgs, nodePackages, ... }:

with pkgs;

buildEnv {
  name = "env-js";
  paths = [
    nodejs
    nodePackages.mermaid-cli
    nodePackages.node2nix
    nodePackages.prettier
  ];
  meta = {
    description = "An environment for JS development";
    priority = 0;
  };
}
