{
  description = "A flake providing a development shell.";

  inputs.pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, ... }@inputs:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" ];
    in
    inputs.flake-utils.lib.eachSystem systems (system:

      with inputs.pkgs.legacyPackages.${system};
      {
        devShell.${system} = mkShell {
          buildInputs = [ hello htop ];
          shellHook = ''
            cat << END

            Nix shell from a flake! To use, run "nix develop"

            END
          '';
          AWESOME = "Yes indeed!";
        };
      }
    );
}
