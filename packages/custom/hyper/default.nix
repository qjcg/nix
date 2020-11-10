{ stdenv
, lib
, fetchurl
, dpkg
, atk
, glib
, pango
, gdk-pixbuf
, gtk3
, cairo
, freetype
, fontconfig
, dbus
, libXi
, libXcursor
, libXdamage
, libXrandr
, libXcomposite
, libXext
, libXfixes
, libXrender
, libX11
, libXtst
, libXScrnSaver
, libxcb
, nss
, nspr
, alsaLib
, cups
, expat
, udev
, libpulseaudio
, libuuid
, at-spi2-atk
, at-spi2-core
, nodejs-14_x
}:
let
  libPath = stdenv.lib.makeLibraryPath [
    stdenv.cc.cc
    gtk3
    atk
    glib
    pango
    gdk-pixbuf
    cairo
    freetype
    fontconfig
    dbus
    libXi
    libXcursor
    libXdamage
    libXrandr
    libXcomposite
    libXext
    libXfixes
    libxcb
    libXrender
    libX11
    libXtst
    libXScrnSaver
    nss
    nspr
    alsaLib
    cups
    expat
    udev
    libpulseaudio
    libuuid
    at-spi2-atk
    at-spi2-core
    nodejs-14_x
  ];

in
stdenv.mkDerivation rec {
  version = "3.0.2";
  pname = "hyper";
  src = fetchurl {
    url = "https://github.com/zeit/hyper/releases/download/${version}/hyper_${version}_amd64.deb";
    sha256 = "d78cf1f3f3928be00426e6409638c17eed9d5fed782065571a8759e4cae6643b";
  };
  nativeBuildInputs = [ dpkg ];
  unpackPhase = ''
    mkdir pkg
    dpkg-deb -x $src pkg
    sourceRoot=pkg
  '';
  installPhase = ''
    mkdir -p "$out/bin"
    mv opt "$out/"
    ln -s "$out/opt/Hyper/hyper" "$out/bin/hyper"
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" --set-rpath "${libPath}:\$ORIGIN" "$out/opt/Hyper/hyper"
    mv usr/* "$out/"
  '';
  dontPatchELF = true;
  meta = with lib; {
    description = "A terminal built on web technologies";
    homepage = https://hyper.is/;
    maintainers = with maintainers; [ puffnfresh ];
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
  };
}
