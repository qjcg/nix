{
  description = "A flake providing single package (and setting defaultPackage).";

  inputs.pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, ... }@inputs:
    {
      overlay = final: prev: { horeb = prev.callPackage ../../packages/horeb; };
      packages.x86_64-linux = import inputs.pkgs.legacyPackages.x86_64-linux { overlays = [ self.overlay ]; };
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.horeb;
    };
}
