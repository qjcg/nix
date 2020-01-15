{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "cassowary";
  version = "0.3.0";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "rogerwelin";
    repo = "cassowary";
    sha256 = "01cdmh2v9rz8rna08hdsddllck6zp9wcrhxdy6hs77zfsbzyfflx";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  modSha256 = "1iylnnmj5slji89pkb3shp4xqar1zbpl7bzwddbzpp8y52fmsv1c";

  meta = with stdenv.lib; {
    description = "Modern cross-platform HTTP load-testing tool";
    homepage = https://github.com/rogerwelin/cassowary ;
    license = licenses.mit;
  };
}
