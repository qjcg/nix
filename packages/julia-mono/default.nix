{ fetchzip, stdenv, }:

stdenv.mkDerivation rec {
  pname = "julia-mono";
  version = "0.022";

  src = fetchzip {
    url =
      "https://github.com/cormullion/juliamono/releases/download/v${version}/JuliaMono.zip";
    sha256 = "07bkjbl6bks4pd43lqfwsaa75ra5642ff9gyc3yqhb5bman6db29";
    stripRoot = false;
  };

  installPhase = ''
    fontdir="$out/share/fonts/truetype"
    install -d "$fontdir"
    install -m644 *.ttf "$fontdir"
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/cormullion/juliamono";
    description = "A monospaced font with reasonable Unicode support.";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
