# NOTE: Update flake.nix to use devshell as done below!
{
  description = "A flake providing a development shell.";

  inputs = {
    devshell.url = "github:numtide/devshell";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    qjcg.url = "github:qjcg/nix";
  };

  outputs = { self, ... }@inputs:
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = [
          inputs.devshell.overlay
          inputs.qjcg.overlay
        ];
      };
    in
    {
      devShell.x86_64-linux = (
        { pkgs, ... }:

          with pkgs;

          mkDevShell {
            name = "devshell-financial";
            packages = [
              jg.envs.env-financial
              jg.overrides.neovim
              zathura
            ];

            shellHook = ''
              # Demonstrate creating a custom shell function.
              func awesome() {
                echo awesome
              }
            '';

            AWESOME = "Yes indeed!";

          }
      ) { inherit pkgs; };
    };
}
