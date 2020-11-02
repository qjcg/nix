{
  description = "A flake providing a development shell.";

  inputs.unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachSystem [
      "x86_64-linux"
      "x86_64-darwin"
    ]
      (system:
        let
          pkgs = inputs.unstable.legacyPackages.${system};
        in
        {
          devShell = import ./shell.nix { inherit pkgs; };
        }
      );
}
