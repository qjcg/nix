{
  description = "A flake providing a k8s development shell.";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, ... }@inputs:
    with inputs.flake-utils.lib;

    eachDefaultSystem (system:
      let
        pkgs = inputs.pkgs.legacyPackages.${system};
      in
      {
        devShell = import ./shell.nix { inherit pkgs; useVim = true; };
      }
    );
}
