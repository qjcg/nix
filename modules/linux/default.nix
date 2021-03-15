{ config, pkgs, ... }:

{
  imports = [
    #./container.nix # TODO: Add option to enable.
    ./fonts.nix
    ./games.nix
    ./gnome.nix
    ./sway.nix
  ];
}
