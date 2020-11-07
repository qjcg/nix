self: super:

let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
in {
  wayfire = waylandOverlay.wayfire.overrideAttrs (oldAttrs: rec {

    # Install desktop file to provide GDM menu option.
    postInstall = ''
      install -Dt $out/share/applications wayfire.desktop
    '';
  });
}
