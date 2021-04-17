{ config, pkgs, ... }:

{
  config = {
    nix.extraOptions = "experimental-features = nix-command flakes";
    nix.package = pkgs.nixUnstable;
    nix.trustedUsers = [ "root" "@wheel" ];

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnsupportedSystem = true;
  };
}
