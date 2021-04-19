{ config, pkgs, ... }:

{
  config = {

    nix = {
      package = pkgs.nixUnstable;
      extraOptions = "experimental-features = nix-command flakes";
      trustedUsers = [ "root" "@wheel" ];
    };

  };
}
