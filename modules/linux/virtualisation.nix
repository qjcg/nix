{ config, pkgs, ... }:

{
  config = {
    virtualisation.docker.enable = true;
    virtualisation.virtualbox.host.enable = true;
  };
}
