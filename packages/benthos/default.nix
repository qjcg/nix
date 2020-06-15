{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  fetchFromGitHub ? pkgs.fetchFromGitHub,
  buildGoModule ? pkgs.buildGoModule,
}:

buildGoModule rec {
  pname = "benthos";
  version = "3.18.0";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "1nh1n5h1mvzpbvqgza45pgzh2rc96g7jj75scglzvzxq62syv9jl";
  };

  buildFlagsArray = [ "-ldflags=-s -w -X github.com/Jeffail/benthos/v3/lib/service.Version=${src.rev}" ];

  subPackages = ["cmd/benthos"];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "1s0p3glszr81wxk0h38n55zcpzchacrnwr725jk4jqdpfifrn1qk";

  meta = with lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
