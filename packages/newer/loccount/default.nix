{ stdenv, fetchFromGitLab, go, python38, }:

stdenv.mkDerivation rec {
  pname = "loccount";
  version = "2.10";

  depsBuildBuild = [ go ];
  nativeBuildInputs = [ python38 ];

  buildPhase = ''
    export GOCACHE=/tmp/cache/go-build
    mkdir -p $GOCACHE
    make
  '';

  installPhase = ''
    mkdir -p "$out"/bin
    GOBIN="$out"/bin make install
  '';

  # Not sure why the bin is being installed as "source". This fixes it.
  postFixup = ''
    mv "$out"/bin/source "$out"/bin/loccount
  '';

  src = fetchFromGitLab {
    owner = "esr";
    repo = "loccount";
    rev = "${version}";
    sha256 = "1qw4zmgp1as52xl9ygn6jbla2vd5q2xab75kwfzf6w06g6psnab2";
  };

  meta = with stdenv.lib; {
    description = "Count source lines of code in a project";
    homepage = "https://gitlab.com/esr/loccount";
    license = licenses.bsd3;
  };
}
