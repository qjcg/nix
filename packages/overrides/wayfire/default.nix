{ pkgs, ... }:

pkgs.wayfire.overrideAttrs (oldAttrs: {

  # Install desktop file to provide GDM menu option.
  postInstall = ''
    install -Dt $out/share/applications wayfire.desktop
  '';
})
