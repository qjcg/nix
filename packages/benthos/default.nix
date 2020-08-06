{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "benthos";
  version = "3.24.1";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "0clygd9za2aaqyz8q77iyjm0v0ilz3v7vi4a3n9n7shsi6hwy3rp";
  };

  buildFlagsArray = [
    "-ldflags=-s -w -X github.com/Jeffail/benthos/v3/lib/service.Version=${src.rev}"
  ];

  subPackages = [ "cmd/benthos" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "12d563j2zlf9v5d25xa0af1529whwrqg0bdj0fm0zjm9vgavyr9s";

  meta = with stdenv.lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
