{ config, pkgs, ... }:

{
  config = {
    services.gpm.enable = true;
    services.printing.enable = true;
    services.openssh.enable = true;
    services.resolved.dnssec = "false";
  };
}
