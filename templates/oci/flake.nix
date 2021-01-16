{
  description = ''
  A flake providing an OCI container image.

  Usage:

    # Build the flake's defaultPackage.
    nix build

    # Load the `nix build` result into the local docker cache.
    docker load < result

    # (OPTIONAL) Check whether this flake's defaultPackage builds.
    nix flake check
  '';

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.pkgs { inherit system; };
    in
      {
        defaultPackage.${system} = with pkgs; ociTools.buildContainer {
          args = [ (writeScript "run.sh" ''
          #!${bash}/bin/bash
          exec ${bash}/bin/bash --version
          '').outPath ];
        };

        checks.${system} = {
          build = self.defaultPackage.${system};
        };
      };

}

