{
  description = "A flake providing a development shell.";

  inputs.pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, ... }@inputs:
    with inputs.pkgs.legacyPackages;
    {
      devShell.x86_64-linux = with x86_64-linux; mkShell {
        buildInputs = [ hello htop ];
        shellHook = ''
          cat << END

          Nix shell from a flake! To use, run "nix develop"

          END
        '';
        AWESOME = "Yes indeed!";
      };

      devShell.x86_64-darwin = with x86_64-darwin; mkShell {
        buildInputs = [ hello htop ];
        shellHook = ''
          cat << END

          Nix shell from a flake! To use, run "nix develop"

          END
        '';
        AWESOME = "Yes indeed!";
      };

    };
}
