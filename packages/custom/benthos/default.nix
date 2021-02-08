{ stdenv, fetchFromGitHub, buildGoModule, }:
let
  inherit (stdenv.lib) fakeSha256;
  version = "3.40.0";
in
buildGoModule {
  inherit version;

  pname = "benthos";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "sha256-Blxzr6GgD492/w5zPm7iK9xfk327KxLjcKUprOrWIh0=";
  };

  vendorSha256 = "sha256-z+by4WX04aOwcINSAUsQuKd/EzQ4WXH64rs1Zgg43yw=";

  buildFlagsArray = [
    "-ldflags="
    "-X github.com/Jeffail/benthos/v3/lib/service.Version=v${version}"
    "-X github.com/Jeffail/benthos/v3/lib/service.DateBuilt=TimelessBuild"
  ];

  subPackages = [ "cmd/benthos" ];

  meta = with stdenv.lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
