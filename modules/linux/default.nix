{ config, pkgs, ... }:

{
  imports = [
    ../common/environment.nix
    ../common/programs.nix
    ../common/nix.nix

    #./container.nix # TODO: Add option to enable.
    ./fonts.nix
    ./games.nix
    ./gnome.nix
    ./networking.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./sway.nix
    ./virtualisation.nix
  ];
}
