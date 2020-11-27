{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "benthos";
  version = "3.34.0";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "sha256-PjwJfRvEw9h1hOue80lM38c6xcUa0xDVvWAK6kJa418=";
  };

  buildFlagsArray = [
    "-ldflags="
    "-X github.com/Jeffail/benthos/v3/lib/service.Version=${src.rev}"
    "-X github.com/Jeffail/benthos/v3/lib/service.DateBuilt=TimelessBuild"
  ];

  subPackages = [ "cmd/benthos" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "sha256-atgn0jIwMD3aKIDbdKNHi4bB5sASqOnyqTLl0P9g2U8=";

  meta = with stdenv.lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
