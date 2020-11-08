{
  debug = rec {
    nixpkgs = import (builtins.getFlake "github:nixos/nixpkgs/nixpkgs-unstable") { system = builtins.currentSystem; };
    env = import ../packages/environments/financial.nix nixpkgs;

    nixpkgsWithEnvOverlay = import (builtins.getFlake "github:nixos/nixpkgs/nixpkgs-unstable") {
      system = builtins.currentSystem;
      overlays = [
        (import ../packages/environments/financial.nix)
      ];
    };
  };
}
