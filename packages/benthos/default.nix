{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "benthos";
  version = "3.23.0";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "1hhxcpba4az72gdkznvr6gqvzxm7vfgmj0dz7il3dwv5mdfblphn";
  };

  buildFlagsArray = [
    "-ldflags=-s -w -X github.com/Jeffail/benthos/v3/lib/service.Version=${src.rev}"
  ];

  subPackages = [ "cmd/benthos" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "1adp037glz28fncycy8jp5sq7qas6x36amn6i6591zhzvs0c61is";

  meta = with stdenv.lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
