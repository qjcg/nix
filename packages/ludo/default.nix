# FIXME: WORK IN PROGRESS. This ludo package currently produces a BROKEN binary that does nothing!
{
  stdenv,
  lib,
  fetchurl,

  glfw, openal,
  libX11, libXcursor, libXrandr, libXinerama,
  libXi, libXxf86vm,
}:

stdenv.mkDerivation rec {
  pname = "ludo-bin";
  version = "0.9.12";

  src = fetchurl {
    url = "https://github.com/libretro/ludo/releases/download/v${version}/Ludo-Linux-x86_64-${version}.tar.gz";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0blmfj35phdr3jsfd1vy6d65fwpic8zvs88z40l5462pqd6d0bp8";
  };

  buildInputs = [ 
    glfw openal
    libX11 libXcursor libXrandr libXinerama
    libXi libXxf86vm
  ];

  #phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/opt/ludo $out/bin
    cp -r * $out/opt/ludo/
    ln -s $out/opt/ludo/ludo $out/bin/ludo
  '';

  meta = with stdenv.lib; {
    description = "A minimalist libretro frontend written in golang";
    homepage = "https://github.com/libretro/ludo";
    license = licenses.gpl3;
  };
}
