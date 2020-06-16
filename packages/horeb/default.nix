{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "horeb";
  version = "0.11.1";

  src = fetchFromGitHub {
    owner = "qjcg";
    repo = "horeb";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0h08fmaf90i5arl8maxhffzh2xm3cd55xq58ym55zvba9yrjks0i";
  };

  buildFlagsArray =
    [ "-ldflags=-s -w -X github.com/qjcg/horeb/pkg/horeb.Version=${version}" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "1dgczgl8i1cpxmm0pws9258xnycwvksvpwvdkccmx4v5civ9ydlx";

  meta = with stdenv.lib; {
    description = "Speaking in tongues via stdout";
    homepage = "https://github.com/qjcg/horeb";
    license = licenses.mit;
  };
}
