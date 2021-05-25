{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchgit;
  inherit (pkgs.lib) fakeSha256 licenses maintainers;
  version = "0.4.0";
in
buildGoModule {
  inherit version;
  pname = "cue";

  src = fetchgit {
    url = "https://cue.googlesource.com/cue";
    rev = "v${version}";
    sha256 = "sha256-rcGEl+CMFyxZKsOKhVimhv5/ONo3xS6FjgKModZGR2o=";
  };

  vendorSha256 = "sha256-eSKVlBgnHR1R0j1lNwtFoIgRuj8GqoMbvuBl/N1SanY=";

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
