{
  description = "A flake providing a development shell.";

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
        devShell = (

          with pkgs;

          mkShell {
            name = "devshell-myapp";
            buildInputs = [ hello ];
            shellHook = ''
              cat << END

              Nix shell from a flake! To use, run "nix develop"

              END
            '';
            AWESOME = "Yes indeed!";
          }
        );
      }
    );
}
