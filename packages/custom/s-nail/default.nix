{ stdenv
, lib
, fetchurl
, getconf
, libiconv
, openssl
, ncurses
,
}:
let
  inherit (lib) platforms;
  version = "14.9.14";
in
stdenv.mkDerivation {
  inherit version;
  name = "s-nail-${version}";

  src = fetchurl {
    url = "https://ftp.sdaoden.eu/s-nail-${version}.tar.gz";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "032ixa9jsdwbc1w8dnxsi4pzmf857yjqrid6zdb3fgy9fi92gqzh";
  };

  buildInputs = [ getconf libiconv ncurses openssl ];

  buildPhase = ''
    make VAL_PREFIX=$out CONFIG=maximal all
  '';

  meta = {
    description = "Simple mail reader.";
    homepage = "https://www.sdaoden.eu/code.html";
    platforms = platforms.unix;
  };
}
