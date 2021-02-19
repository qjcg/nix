{ stdenv, fetchFromGitHub, buildGoModule, }:
let
  inherit (stdenv.lib) fakeSha256;
  version = "3.41.1";
in
buildGoModule {
  inherit version;

  pname = "benthos";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "sha256-JZ+G4I+2IimATbekqM16n1JULYjSyi5tSL0DNDY4zt0=";
  };

  vendorSha256 = "sha256-z+by4WX04aOwcINSAUsQuKd/EzQ4WXH64rs1Zgg43yw=";

  buildFlagsArray = [
    "-ldflags="
    "-X github.com/Jeffail/benthos/v3/lib/service.Version=v${version}"
    "-X github.com/Jeffail/benthos/v3/lib/service.DateBuilt=ReproduciblyTimeless"
  ];

  subPackages = [ "cmd/benthos" ];

  meta = with stdenv.lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
