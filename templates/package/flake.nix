# Example from: https://www.tweag.io/blog/2020-05-25-flakes/
{
  description = "A flake providing single package (and setting defaultPackage).";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, pkgs }:
    {
      defaultPackage.x86_64-linux =
        with import pkgs { system = "x86_64-linux"; };
        stdenv.mkDerivation {
          name = "defaultpackage-hello";
          src = self;
          buildPhase = "gcc -o hello " + ./hello.c;
          installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
        };

      checks.x86_64-linux = {
        build = self.defaultPackage.x86_64-linux;

        # See https://nixos.org/manual/nixos/unstable/index.html#sec-nixos-tests
        test = with import (pkgs + "/nixos/lib/testing-python.nix") { system = "x86_64-linux"; };

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
              client.fail("echo999 hello")
            '';
          };
      };
    };
}
