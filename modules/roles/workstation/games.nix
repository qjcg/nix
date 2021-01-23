{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkMerge;
  cfg = config.roles.workstation;
in
mkMerge [
  (mkIf cfg.games {
    environment.systemPackages = with pkgs; [
      nethack
    ];
    services.gnome3.games.enable = true;
  })
]
