{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "benthos";
  version = "3.20.0";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "0scdi3kxzb1mzxnndxbw9dbgxc0fvscg7jrmvyjfrqa6x1m71all";
  };

  buildFlagsArray = [
    "-ldflags=-s -w -X github.com/Jeffail/benthos/v3/lib/service.Version=${src.rev}"
  ];

  subPackages = [ "cmd/benthos" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "0ad0h6lraz0b51zm8jc079zb34rmggv1qxra1rh58pbvfsfl11g7";

  meta = with stdenv.lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
