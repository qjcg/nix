{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchgit;
  inherit (pkgs.lib) fakeSha256 licenses maintainers;
  version = "0.3.2";
in
buildGoModule {
  inherit version;
  pname = "cue";

  src = fetchgit {
    url = "https://cue.googlesource.com/cue";
    rev = "v${version}";
    sha256 = "sha256-FDHMCl5P9SuaBoX1rLLPe8MG9i72S7YPqH803wi+z2U=";
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
