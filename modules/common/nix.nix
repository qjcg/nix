{ config, pkgs, ... }:

{
  config = {

    nix = {
      package = pkgs.jg.unstable.nixUnstable;
      extraOptions = "experimental-features = nix-command flakes";
      trustedUsers = [ "root" "@wheel" ];
    };

  };
}
