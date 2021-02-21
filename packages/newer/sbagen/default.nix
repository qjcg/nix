{ lib, multiStdenv, fetchurl }:
let
  inherit (lib) fakeSha256 licenses;
  pname = "sbagen";
  version = "1.4.5";
in
multiStdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://uazu.net/sbagen/${pname}-${version}.tgz";
    sha256 = "sha256-ArBdD4nxuqbmsoL0pdsnm0xZ7m/EAKWpaGqhEofyIOQ=";
  };

  postPatch = ''
    patchShebangs ./mk
  '';

  buildPhase = "./mk";

  installPhase = ''
    mkdir -p $out/{bin,share/sbagen/doc}
    cp -r --target-directory=$out/share/sbagen examples scripts river1.ogg river2.ogg
    cp sbagen $out/bin
    cp --target-directory=$out/share/sbagen/doc README.txt SBAGEN.txt theory{,2}.txt {wave,holosync,focus,TODO}.txt
  '';

  meta = {
    description = "Binaural sound generator";
    homepage = "http://uazu.net/sbagen";
    license = licenses.gpl2;
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}
