{ config, pkgs, ... }:

{
  imports = [
    ../common/emacs.nix
    ../common/environment.nix
    ../common/nix.nix
    ../common/nixpkgs.nix
    ../common/programs.nix

    #./container.nix # TODO: Add option to enable.
    ./environment.nix
    ./fonts.nix
    ./games.nix
    ./gnome.nix
    ./networking.nix
    ./nix.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./sway.nix
    ./virtualisation.nix
  ];
}
