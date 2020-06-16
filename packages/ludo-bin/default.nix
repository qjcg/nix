{
  stdenv,
  fetchurl,

  glfw, openal,
  libX11, libXcursor, libXrandr, libXinerama,
  libXi, libXxf86vm,
  undmg,
}:

let
  version = "0.11.1";

  releaseFile =
    if stdenv.isDarwin then
    "Ludo-OSX-x86_64-${version}.dmg" else
    "Ludo-Linux-x86_64-${version}.tar.gz";

  releaseFileSha256 =
    if stdenv.isDarwin then
    "0xhbdd4ba2d27xkys31fww721ihsmhsbdryl9w53qnh143hs7slp" else
    "0blmf11111111jsfd1vy6d65fwpic8zvs88z40l5462pqd6d0bp8";

  installPhaseScript =
    if stdenv.isDarwin then
    ''
    '' else
    ''
    '';
in
stdenv.mkDerivation rec {
  inherit version;

  pname = "ludo-bin";

  src = fetchurl {
    url = "https://github.com/libretro/ludo/releases/download/v${version}/${releaseFile}";
    sha256 = "${releaseFileSha256}";
  };

  buildInputs = [ 
    glfw openal
    libX11 libXcursor libXrandr libXinerama
    libXi libXxf86vm
    undmg
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
