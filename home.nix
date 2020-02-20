# home-manager configuration.
# See https://github.com/rycee/home-manager

# Below are machine-specific configurations.
# To choose a machine, run (for example):
#   home-manager -A luban switch
# Ref: home-manager(1)

let
  pkgs = import <nixpkgs> {
    overlays = [
      (import ./packages)

      # TODO: Clearly distinguish/separate overlays (below) from packages.
      (import ./packages/neovim)
      (import ./packages/st)
      (import ./packages/sxiv)
      (import ./packages/vscodium-with-extensions)

      (import ./packages/overrides.nix)
      (import ./packages/environments.nix)
    ];
  };
  lib = pkgs.lib;

  secrets = import ./secrets.nix;
in
  {
    eiffel = import ./machines/eiffel/home.nix { inherit pkgs lib secrets; };
  }
