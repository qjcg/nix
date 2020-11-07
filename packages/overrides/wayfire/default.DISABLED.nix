{ pkgs ? import (builtins.fetchTarball "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz") }:

{
  wayfire = pkgs.wayfire.overrideAttrs (oldAttrs: rec {

    # Install desktop file to provide GDM menu option.
    postInstall = ''
      install -Dt $out/share/applications wayfire.desktop
    '';
  });
}
