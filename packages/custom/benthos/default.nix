{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256 licenses;
  version = "3.42.0";
in
buildGoModule {
  inherit version;
  pname = "benthos";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "sha256-nX7KpEtHYM6UtZl+7Cb73glLeXoM2TuyDGmLxUaE8Cw=";
  };

  vendorSha256 = "sha256-z+by4WX04aOwcINSAUsQuKd/EzQ4WXH64rs1Zgg43yw=";

  buildFlagsArray = [
    "-ldflags="
    "-X github.com/Jeffail/benthos/v3/lib/service.Version=v${version}"
    "-X github.com/Jeffail/benthos/v3/lib/service.DateBuilt=ReproduciblyTimeless"
  ];

  subPackages = [ "cmd/benthos" ];

  meta = {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
