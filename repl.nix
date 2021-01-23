# USAGE: nix repl repl.nix
let
  inherit (builtins) getFlake trace;
in
{

  # Use the "repl" attrset for easy discoverability via tab-completion.
  repl = rec {
    # The top-level flake in this repo.
    thisFlake = getFlake (toString ./.);

    # Upstream nixpkgs flake.
    nixpkgs-unstable = getFlake "github:nixos/nixpkgs/nixpkgs-unstable";

    # DevShell flake.
    devshell = getFlake "github:numtide/devshell";


    # Demonstrate adding this flake's top-level "overlay" to upstream nixpkgs via flake import.
    nixpkgsWithOverlay = import nixpkgs-unstable {
      overlays = [ thisFlake.overlay devshell.overlay ];
    };

  };
}
