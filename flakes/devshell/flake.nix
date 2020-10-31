{
  description = "A flake providing a development shell.";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs: {
    devShell.x86_64-linux = inputs.pkgs.legacyPackages.x86_64-linux.mkShell {

      buildInputs = with inputs.pkgs.legacyPackages.x86_64-linux; [
        hello
      ];

      shellHook = ''
        echo Nix shell from a flake!
        echo To use, run "nix develop"
      '';

      AWESOME = "Yes, Indeed!";

    };
  };
}
