{
  description = "A flake providing a k8s development shell.";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
      in
      {
        devShell = import ./shell.nix {
          inherit pkgs;
          useVim = true;
        };
      }
    );
}
