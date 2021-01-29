{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-nix";
  paths = [
    agenix
    cachix
    direnv
    nix-bash-completions
    nix-direnv
    nix-index
    nixpkgs-fmt
  ];
  meta = {
    priority = 0;
    description = "An environment for working with Nix and NixOS";
  };
}
