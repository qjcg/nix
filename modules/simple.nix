{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ hello ];
}
