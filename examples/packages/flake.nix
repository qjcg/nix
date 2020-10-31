{
  description = "A flake providing an MVP container.";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:

    with inputs.pkgs.legacyPackages.x86_64-linux;
    {

      packages.x86_64-linux = {
        horeb = .legacyPackages.x86_64-linux.callPackage ../../packages/horeb;
      };

      defaultPackage.x86_64-linux = self.packages.x86_64-linux.horeb;

    };
}
