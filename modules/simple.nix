{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gomuks ];
}
