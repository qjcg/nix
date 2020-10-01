{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "horeb";
  version = "0.12.0";

  src = fetchFromGitHub {
    owner = "qjcg";
    repo = "horeb";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "sha256-lHTuiaRy2sgeKB838W8QQXiTGuoEG0izoIBp+4d2zmI=";
  };

  buildFlagsArray =
    [ "-ldflags=-s -w -X github.com/qjcg/horeb/pkg/horeb.Version=${version}" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "sha256-rmZGr6TcdDPBkyNRMY0vfUyiwoHLuGXGw+XKlVMzuH0=";

  meta = with stdenv.lib; {
    description = "Speaking in tongues via stdout";
    homepage = "https://github.com/qjcg/horeb";
    license = licenses.mit;
  };
}
