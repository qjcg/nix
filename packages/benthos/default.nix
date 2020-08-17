{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "benthos";
  version = "3.25.0";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "1nw7spz9pkcga0qg5cb5cgs0l3qji11n45ka9q5j8bfcafjlaw50";
  };

  buildFlagsArray = [
    "-ldflags=-s -w -X github.com/Jeffail/benthos/v3/lib/service.Version=${src.rev}"
  ];

  subPackages = [ "cmd/benthos" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "0y3sfyvrhj5kwjii0lflz02qqx6lhw8vndqmrdp57knnvcyhwgy1";

  meta = with stdenv.lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
