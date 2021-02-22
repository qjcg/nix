{
  description = "A flake providing a development shell.";

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachSystem [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
    ]
      (system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.devshell.overlay ];
          };

          inherit (pkgs.devshell) mkShell;
        in
        {
          devShell = mkShell {
            name = "devshell-demo";

            packages = with pkgs; [
              python39
            ];

            commands = [
              { package = "nixpkgs-fmt"; }
              { package = "zathura"; }
            ];

            env = [
              { name = "AWESOME"; value = "Yes indeed!"; }
            ];

          };

        }
      );
}
