# i3-compatible wayland compositor.
{ config, pkgs, ... }:

{
  config = {

    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [ ];
        allowedUDPPorts = [ ];
      };
    };

  };
}
