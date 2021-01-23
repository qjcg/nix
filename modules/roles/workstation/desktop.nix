{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkMerge;
  cfg = config.roles.workstation;
in
mkMerge [
  (mkIf cfg.desktop {
    environment.systemPackages = with pkgs; [
      jg.envs.env-desktop
    ];
  })
]
