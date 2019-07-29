# home-manager configuration.
# See https://github.com/rycee/home-manager

# Below are machine-specific configurations.
# To choose a machine, run (for example):
#   home-manager -A luban switch
# Ref: home-manager(1)

let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  secrets = import ./secrets.nix;
in
{
  luban   = import ./machines/luban { inherit lib pkgs secrets; };
  eiffel  = import ./machines/eiffel { inherit lib pkgs secrets; };
}
