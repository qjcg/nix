{
  description = "A flake providing an emacs package.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    emacs.url = "github:nix-community/emacs-overlay";
    wayland.url = "github:colemickens/nixpkgs-wayland";
    wayland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs {
          system = "${system}";
          overlays = [
            inputs.emacs.overlay
            inputs.wayland.overlay
          ];
        };
      in
      {
        defaultPackage = pkgs.emacsWithPackagesFromUsePackage {
          config = ../../../files/emacs/init.el;
          package = pkgs.emacs-pgtk;
        };

        checks = {
          build = self.defaultPackage.${system};
        };
      }
    );
}
