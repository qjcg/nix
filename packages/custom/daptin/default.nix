{ lib, fetchFromGitHub, buildGoModule }:
let
  inherit (lib) fakeSha256 licenses;
  version = "0.9.4";
in
buildGoModule {
  inherit version;
  pname = "daptin";

  src = fetchFromGitHub {
    owner = "daptin";
    repo = "daptin";
    rev = "v${version}";
    sha256 = "sha256-yqhCDyMFngz6PGOXgN76t89yWQQEApMIFQeMddy3tp8=";
  };

  subPackages = [ "." ];

  buildFlagsArray =
    [ "-ldflags=-s" "-X github.com/daptin/daptin/fs.Version=v${version}" ];

  vendorSha256 = "sha256-Xg1TEwXceYqV2svnmhsJu8xuv8X8BqVrOGsMLkS8x+8=";

  meta = {
    description =
      "The most powerful ready to use data and services API server.";
    homepage = "https://daptin.github.io/daptin/";
    license = licenses.gpl3;
  };
}
