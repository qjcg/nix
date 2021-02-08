{ buildGoModule, fetchgit, stdenv }:
let
  inherit (stdenv.lib) fakeSha256;

  version = "0.3.0-beta.4";
in
buildGoModule {
  inherit version;

  pname = "cue";

  src = fetchgit {
    url = "https://cue.googlesource.com/cue";
    rev = "v${version}";
    sha256 = "sha256-kMo0NPUOJUSmzdngbRZe1MQxXnrrZIauxaPAZhYmGWQ=";
  };

  vendorSha256 = "sha256-9ai1Wbk6ftcXHjVEWaL8drxZnhgAwF8+OXNI95CrNjc=";

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
