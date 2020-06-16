{ stdenv, fetchFromGitLab, go, python27, }:

stdenv.mkDerivation rec {
  pname = "loccount";
  version = "2.8";

  depsBuildBuild = [ go ];
  nativeBuildInputs = [ python27 ];

  patches = [ ./01_fix-generate.patch ];

  configurePhase = ''
    substituteAllInPlace ./loccount.go
  '';

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
    sha256 = "0iva662fppzhqv75sc8rkjk75wnn26qk4s8vdh68nvvqjsd2sm4r";
  };

  meta = with stdenv.lib; {
    description = "Count source lines of code in a project";
    homepage = "https://gitlab.com/esr/loccount";
    license = licenses.bsd3;
  };
}

