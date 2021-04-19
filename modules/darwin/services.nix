{ config, pkgs, ... }:

{
  config = {
    # Enable the nix-daemon service (multi-user install).
    services.nix-daemon.enable = true;
  };
}
