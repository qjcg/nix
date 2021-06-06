{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-nix";
  paths = [
    # Command line client for Nix binary cache hosting.
    # https://github.com/cachix/cachix
    cachix

    # direnv is an extension for your shell. It augments existing
    # shells with a new feature that can load and unload environment
    # variables depending on the current directory.
    # https://github.com/direnv/direnv
    direnv

    # Bash completion for the Nix command line tools.
    # https://github.com/hedning/nix-bash-completions
    nix-bash-completions

    # A fast, persistent use_nix/use_flake implementation for direnv
    # https://github.com/nix-community/nix-direnv
    nix-direnv

    # Visualise which gc-roots to delete to free some space in your nix store
    # https://github.com/symphorien/nix-du
    nix-du

    # Quickly locate nix packages with specific files.
    # https://github.com/bennofs/nix-index
    # FIXME: Commented out due to broken build (2021-06-06).
    #nix-index

    # Prefetch any fetcher function call, e.g. a package source.
    # https://github.com/msteen/nix-prefetch
    nix-prefetch

    # Interactively browse dependency graphs of Nix derivations. 
    # https://github.com/utdemir/nix-tree
    nix-tree

    # Nix code formatter for nixpkgs.
    # https://github.com/nix-community/nixpkgs-fmt    
    nixpkgs-fmt
  ];
  meta = {
    priority = 0;
    description = "An environment for working with Nix and NixOS";
  };
}
