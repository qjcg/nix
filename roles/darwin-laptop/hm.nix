# home-manager configuration.
#
# Uses the home-manager nix-darwin module, which provides the
# home-manager.users.<user> options below.
# Ref: https://rycee.gitlab.io/home-manager/index.html#sec-install-nix-darwin-module

{ pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
  ];

  # Users should be defined in secrets.nix.
  home-manager.users.jgosset = {
    imports = [
      ./hm_packages.nix
      ./hm_programs.nix
      ./hm_xdg.nix
    ];
  };
}
