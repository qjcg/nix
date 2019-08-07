{
  stdenv,
  lib,
  fetchurl,

  glfw, openal,
  libX11, libXcursor, libXrandr, libXinerama,
  libXi, libXxf86vm,
}:

stdenv.mkDerivation rec {
  name = "ludo-bin-${version}";
  version = "0.7.1";

  src = fetchurl {
    url = "https://github.com/libretro/ludo/releases/download/v${version}/Ludo-Linux-x86_64-${version}.tar.gz";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0xyh1sxlk8fgah9nkwlm7p9f4xx1sp26bl61x8qfvcp4kmfgviz9";
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

  meta = {
    description = "A minimalist libretro frontend written in golang";
    homepage = https://github.com/libretro/ludo ;
    license = lib.licenses.gpl3;
  };
}
