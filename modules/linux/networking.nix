# i3-compatible wayland compositor.
{ config, pkgs, ... }:

{
  config = {
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ ];
    networking.firewall.allowedUDPPorts = [ ];
  };
}
