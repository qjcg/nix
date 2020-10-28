# Module with settings appropriate for a nixos-container.
# See https://www.tweag.io/blog/2020-07-31-nixos-flakes/
{ config, pkgs, ... }:

{
  boot.isContainer = true;

  # DHCP not needed/used in systemd-nspawn container? (To confirm).
  networking.useDHCP = false;
}
