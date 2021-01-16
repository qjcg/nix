{
  description = ''
  A flake providing a docker container image.

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
        defaultPackage.${system} = with pkgs; dockerTools.buildImage {
          name = "hello";
          tag = "latest";
          created = "now";
          contents = hello;

          config.cmd = [ "/bin/hello" ];
        };

        checks.${system} = {
          build = self.defaultPackage.${system};
        };
      };

}

