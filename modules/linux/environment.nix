{ config, pkgs, ... }:

{
  config = {

    # The following base config is always applied when this role is enabled.
    environment.systemPackages = with pkgs; [
      firefox
      torbrowser
    ];

  };
}
