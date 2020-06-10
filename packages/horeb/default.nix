{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  name = "horeb-${version}";
  version = "0.11.1";

  src = fetchFromGitHub {
    owner = "qjcg";
    repo = "horeb";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0h08fmaf90i5arl8maxhffzh2xm3cd55xq58ym55zvba9yrjks0i";
  };

  # FIXME: Evaluate whether `go build` can be used here instead.
  buildPhase = ''
    CGO_ENABLED=0 go install -ldflags='-s -w -X github.com/qjcg/horeb/pkg/horeb.Version=${src.rev}' ./...
  '';

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "0b9ys37d62w5pwjlkbazswmqvswkqksq7z0az16vwlb2psd0k3kb";

  meta = with lib; {
    description = "Speaking in tongues via stdout.";
    homepage = https://github.com/qjcg/horeb;
    license = licenses.mit;
  };
}
