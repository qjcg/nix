{ config, pkgs, ... }:

{
  config = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnsupportedSystem = true;
  };
}
