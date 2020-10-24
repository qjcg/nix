{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome3.gitg
    gnome3.gnome-tweak-tool
    gnome3.rhythmbox
    gnome3.shotwell
    lollypop
    olive-editor
    pitivi
    shotcut
    vocal
  ];

  # FIXME: Disabled, not building (2020-10-12).
  #services.gnome3.games.enable = true;
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.displayManager.defaultSession = "gnome";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
}
