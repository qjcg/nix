{ config, pkgs, ... }:

{
  config = {

    environment.systemPackages = with pkgs; [
      nethack
      jg.overrides.retroarch
    ];

    services.gnome.games.enable = true;

  };
}
