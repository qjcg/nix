# home-manager configuration.
#
# Uses the home-manager nix-darwin module, which provides the
# home-manager.users.<user> options below.
# Ref: https://rycee.gitlab.io/home-manager/index.html#sec-install-nix-darwin-module

{ pkgs, ... }:

let
  hm_config = (import ./hm_packages.nix { inherit pkgs; })
    // (import ./hm_programs.nix) // (import ./hm_xdg.nix);
in {
  imports = [ <home-manager/nix-darwin> ];

  # Users should be defined in secrets.nix.
  home-manager.users.jgosset = hm_config;
}
