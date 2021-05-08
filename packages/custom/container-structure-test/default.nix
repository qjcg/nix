{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256 licenses;

  name = "container-structure-test";
  version = "1.10.0";
in
buildGoModule {
  inherit version;

  pname = name;

  src = fetchFromGitHub {
    owner = "GoogleContainerTools";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-zfnF4MrgQet7ijE2RmGh5D4A3UkrXZicWH1+dkVyfjY=";
  };

  vendorSha256 = null;
  subPackages = [ "cmd/${name}" ];

  buildFlagsArray = [
    "-ldflags=-s -w"
    "-X github.com/GoogleContainerTools/${name}/pkg/version.version=v${version}"
    "-X github.com/GoogleContainerTools/${name}/pkg/version.buildDate=timeless-and-reproducible"
  ];

  meta = {
    description = "Validate the structure of your container images";
    homepage = "https://github.com/GoogleContainertools/container-structure-test";
    license = licenses.asl20;
  };
}
