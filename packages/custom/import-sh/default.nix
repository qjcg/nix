{ stdenv, lib, fetchFromGitHub, }:
let
  inherit (lib) licenses platforms;
  version = "0.1.0";
in
stdenv.mkDerivation {
  inherit version;
  pname = "import-sh";

  src = fetchFromGitHub {
    owner = "importpw";
    repo = "import";
    rev = "cfa731d1ca32465a91994c928b0f941bf9ff31e0";
    sha256 = "1axprjvj7jwqr9crvn654kw91g81pp5mg52hqp3i7al7gp9vymj0";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp import.sh $out/bin/import.sh
  '';

  meta = {
    description =
      "A simple and fast module system for Bash and other Unix shells";
    homepage = "https://import.pw";
    platforms = platforms.unix;
  };
}
