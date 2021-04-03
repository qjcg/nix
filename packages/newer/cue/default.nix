{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchgit;
  inherit (pkgs.lib) fakeSha256 licenses maintainers;
  version = "0.3.0";
in
buildGoModule {
  inherit version;
  pname = "cue";

  src = fetchgit {
    url = "https://cue.googlesource.com/cue";
    rev = "v${version}";
    sha256 = "sha256-tafAkQGn2aT6A1u7OeAfsZSST3bRshFPye3Y+noCaMA=";
  };

  vendorSha256 = "sha256-d8p/vsbJ/bQbT2xrqqCoU1sQB8MrwKOMwEYhNYTWe4I=";

  doCheck = false;

  subPackages = [ "cmd/cue" ];

  buildFlagsArray =
    [ "-ldflags=-X cuelang.org/go/cmd/cue/cmd.version=${version}" ];

  meta = {
    description =
      "A data constraint language which aims to simplify tasks involving defining and using data";
    homepage = "https://cuelang.org/";
    maintainers = [ maintainers.solson ];
    license = licenses.asl20;
  };
}
