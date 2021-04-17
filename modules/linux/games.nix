{ config, pkgs, ... }:

{
  config = {

    environment.systemPackages = with pkgs; [
      nethack
      jg.overrides.retroarch
    ];

    services.gnome3.games.enable = true;

  };
}
