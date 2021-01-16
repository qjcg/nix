{
  description = "A flake providing a container image.";

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

