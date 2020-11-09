{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-nix";
  paths = [
    #cachix # NOTE: Requires a RIDICULOUSLY long ghc compilation.
    direnv
    lorri
    nix-bash-completions
    nix-index
    #nixops # NOTE: Broken build 2020-07-06
    nixpkgs-fmt
  ];
  meta = {
    priority = 0;
    description = "An environment for working with Nix";
  };
}
