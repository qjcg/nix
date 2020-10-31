{
  description = "A flake providing a development shell.";

  inputs.pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, ... }@inputs:
    with inputs.pkgs.legacyPackages.x86_64-linux;
    {
      devShell.x86_64-linux = mkShell {
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
