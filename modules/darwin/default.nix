{ config, pkgs, ... }:

{
  imports = [
    ../common/emacs.nix
    ../common/nix.nix
    ../common/nixpkgs.nix
    ../common/programs.nix

    #./fonts.nix
    ./services.nix
    ./system.nix
  ];
}
