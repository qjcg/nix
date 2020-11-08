final: prev:

{
  wayfire = prev.wayfire.overrideAttrs (oldAttrs: rec {

    # Install desktop file to provide GDM menu option.
    postInstall = ''
      install -Dt $out/share/applications wayfire.desktop
    '';
  });
}
