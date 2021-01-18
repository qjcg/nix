{ stdenv, fetchFromGitHub, buildGoModule, }:

let
	inherit (stdenv.lib) fakeSha256;
in
buildGoModule rec {
  pname = "benthos";
  version = "3.38.0";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "sha256-ytClH27ehw0VSu2PnmZrw7zRT7FZ9g5Qqz0ZRFd29FE=";
  };

  vendorSha256 = "sha256-h9riGjdGBNZnJZo1FXf+WahITvFvxvGLWNWcYWFhSRc=";

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
