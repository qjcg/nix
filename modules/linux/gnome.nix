# GNOME desktop environment.
{ config, pkgs, ... }:

{
  config = {

    environment.systemPackages = with pkgs; [
      gnome.gitg
      gnome.gnome-tweak-tool
      gnome.rhythmbox
      gnome.shotwell
      lollypop
      olive-editor
      pitivi
      shotcut
      vocal
    ];

    services.xserver.enable = true;
    services.xserver.layout = "us";
    services.xserver.displayManager.defaultSession = "gnome";
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };

}
