# Nixos-container appropriate settings.
# See https://www.tweag.io/blog/2020-07-31-nixos-flakes/
{ config, pkgs, ... }:

{
  config = {

    boot.isContainer = true;

    # See [Container Networking](https://nixos.org/manual/nixos/unstable/index.html#sec-container-networking).
    # DHCP not needed/used in systemd-nspawn container? (To confirm).
    networking.useDHCP = false;

  };
}
