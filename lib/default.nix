let
  inherit (builtins) getFlake trace;
in
{

  # Namespace this "debugging session" inside a debug attr for easy
  # discoverability via tab-completion.
  # Use via `nix repl default.nix`.
  debug = rec {
    # The top-level flake in this repo.
    thisFlake = getFlake (toString ../.);

    # Upstream nixpkgs flake.
    nixpkgs-unstable = getFlake "github:nixos/nixpkgs/nixpkgs-unstable";

    # Demonstrate adding this flake's overlay to upstream nixpkgs via flake import.
    nixpkgsWithOverlay = import nixpkgs-unstable {
      overlays = [ thisFlake.overlay ];
    };
  };
}
