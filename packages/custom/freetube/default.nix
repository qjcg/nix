# Adapted from: https://github.com/JorelAli/nixos/blob/master/extrapackages/freetube.nix
{ pkgs
, lib
, stdenv
, fetchurl
, makeWrapper
, libpulseaudio
, gtk3
, glibc
, libuuid
, alsaLib
, atk
, cairo
, cups
, dbus
, expat
, fontconfig
, gdk_pixbuf
, glib
, gnome2
, gtk2
, nspr
, nss
, systemd
, xlibs
, gtk3-x11
, at_spi2_atk
, at_spi2_core
,
}:
let
  inherit (lib) licenses makeLibraryPath platforms;
  version = "0.7.1";
  mclibPath = makeLibraryPath [ libpulseaudio ];
in
stdenv.mkDerivation {
  inherit mclibPath version;
  pname = "freetube";

  src = fetchurl {
    url =
      "https://github.com/FreeTubeApp/FreeTube/releases/download/v0.7.1-beta/FreeTube-0.7.1-linux.tar.xz";
    sha256 = "06zn624wvffpl5a7dh8c5dx6aml5dd1rlnazba86xcjc0vkagjw6";
  };

  phases = [ "unpackPhase" "buildPhase" "installPhase" "fixupPhase" ];

  buildInputs = [ gtk3 ];
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/opt/freetube
    cp -R . $out/opt/freetube

    makeWrapper $out/opt/freetube/freetube $out/opt/freetube/freetube-wrapper \
      --suffix LD_LIBRARY_PATH : ${mclibPath} \
      --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"

    ln -s $out/opt/freetube/freetube-wrapper $out/bin/freetube
  '';

  dontPatchELF = true; # Needed for local libraries

  # TODO: Clean up this list
  preFixup =
    let
      libPath = makeLibraryPath [
        glibc
        stdenv.cc.cc.lib
        libuuid

        alsaLib
        atk
        cairo
        cups
        dbus
        expat
        fontconfig
        gdk_pixbuf
        glib
        gnome2.pango
        gnome2.GConf
        gtk2
        libpulseaudio
        nspr
        nss
        systemd
        xlibs.libX11
        xlibs.libxcb
        xlibs.libXcomposite
        xlibs.libXcursor
        xlibs.libXdamage
        xlibs.libXext
        xlibs.libXfixes
        xlibs.libXi
        xlibs.libXrender
        xlibs.libXtst
        xlibs.libXScrnSaver
        xlibs.libXrandr

        gtk3-x11
        at_spi2_atk
        at_spi2_core

      ];

    in
    ''
      patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${libPath}:$out/opt/freetube" \
        $out/opt/freetube/freetube

    '';
  #patchelf \
  #  --set-rpath "${libcefPath}" \
  #  $out/opt/freetube/libcef.so

  #patchelf \
  #  --set-rpath "${liblauncherPath}:$out/opt/freetube" \
  #  $out/opt/freetube/liblauncher.so

  meta = {
    description = "The private YouTube client";
    homepage = "https://freetubeapp.io/";
    platforms = platforms.linux;
    license = licenses.gpl3;
  };
}
