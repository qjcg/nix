{
  description = "A flake providing a development shell.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    {
      devShell.x86_64-linux = (
        { pkgs, ... }:

          with pkgs;

          mkShell {
            name = "devshell-myapp";
            buildInputs = [ hello ];
            shellHook = ''
              cat << END

              Nix shell from a flake! To use, run "nix develop"

              Is this AWESOME? -> $AWESOME

              END
            '';
            AWESOME = "Yes indeed!";
          }
      ) { pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux; };
    };
}
