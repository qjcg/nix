{ stdenv, fetchFromGitHub, buildGoModule, }:

let
	inherit (stdenv.lib) fakeSha256;
in
buildGoModule rec {
  pname = "benthos";
  version = "3.37.0";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "sha256-TvMf+h8z5ZCXKUwtGK2nlnwsunO9yRV2X3OyIGDLMcg=";
  };

  vendorSha256 = "sha256-GEi6Q3Y5h04B64u8iZZ2Tcna7xMLvXhMKlZPQkFRmJ4=";

  buildFlagsArray = [
    "-ldflags="
    "-X github.com/Jeffail/benthos/v3/lib/service.Version=${src.rev}"
    "-X github.com/Jeffail/benthos/v3/lib/service.DateBuilt=TimelessBuild"
  ];

  subPackages = [ "cmd/benthos" ];

  meta = with stdenv.lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
