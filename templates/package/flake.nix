# Example from: https://www.tweag.io/blog/2020-05-25-flakes/
{
  description = "A flake providing single package (and setting defaultPackage).";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.pkgs { system = "${system}"; };
      in
      {
        defaultPackage =
          with pkgs;
          stdenv.mkDerivation {
            name = "defaultpackage-hello";
            src = self;
            nativeBuildInputs = [ gcc ];
            buildPhase = "gcc -o hello " + ./hello.c;
            installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
          };

        checks = {
          build = self.defaultPackage.${system};

          # NOTE: Below test fails to run on darwin.
        } // pkgs.lib.optionalAttrs pkgs.stdenv.isLinux {

          # See https://nixos.org/manual/nixos/unstable/index.html#sec-nixos-tests
          test = with import (inputs.pkgs + "/nixos/lib/testing-python.nix") { system = "${system}"; };

            makeTest {
              nodes = {
                client = { ... }: {
                  # FIXME
                  #imports = [ self.defaultPackage.x86_64-linux ];
                };
              };

              testScript = ''
                start_all()
                client.wait_for_unit("multi-user.target")
                client.succeed("echo hello")
              '';
            };
        };
      });
}
