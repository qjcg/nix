{ stdenv, fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "daptin";
  version = "0.9.2";

  src = fetchFromGitHub {
    owner = "daptin";
    repo = "daptin";
    rev = "v${version}";
    sha256 = "0g7acbsgpvy96mp4gffsalcm2507nkg0s889psm4x12hqfv42j32";
  };

  subPackages = [ "." ];

  buildFlagsArray =
    [ "-ldflags=-s" "-X github.com/daptin/daptin/fs.Version=${src.rev}" ];

  vendorSha256 = "0ghka8gkikf3z3fdbsn4k1r4hy342qrhfpcw7lncmilpcdkkkl7a";

  meta = with stdenv.lib; {
    description =
      "The most powerful ready to use data and services API server.";
    homepage = "https://daptin.github.io/daptin/";
    license = licenses.gpl3;
  };
}
