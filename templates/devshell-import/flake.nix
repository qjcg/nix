{
  description = "A flake providing a development shell.";

  inputs.unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = inputs.unstable.legacyPackages.${system};
      in
      {
        devShell = import ./shell.nix { inherit pkgs; };
      }
    );
}
