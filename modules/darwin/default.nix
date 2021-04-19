{ config, pkgs, ... }:

{
  imports = [
    ../common/nix.nix
    ../common/nixpkgs.nix
    ../common/programs.nix

    #./fonts.nix
    ./services.nix
  ];
}
