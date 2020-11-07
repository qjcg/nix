{ buildGoModule, fetchgit, stdenv }:

buildGoModule rec {
  pname = "cue";
  version = "0.3.0-alpha4";

  src = fetchgit {
    url = "https://cue.googlesource.com/cue";
    rev = "v${version}";
    sha256 = "0ajff3c6zkzbm0n5982d0ijwy6zflf12df9g8xglx6a0pvy9idbc";
  };

  vendorSha256 = "136igsvw1x96rf8vlpzw325y0pfjxypy3dbc8wji3my9s5w9267h";

  doCheck = false;

  subPackages = [ "cmd/cue" ];

  buildFlagsArray =
    [ "-ldflags=-X cuelang.org/go/cmd/cue/cmd.version=${version}" ];

  meta = {
    description =
      "A data constraint language which aims to simplify tasks involving defining and using data";
    homepage = "https://cuelang.org/";
    maintainers = with stdenv.lib.maintainers; [ solson ];
    license = stdenv.lib.licenses.asl20;
  };
}
