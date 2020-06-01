{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  name = "barr-${version}";
  version = "1.14.11-alpha";

  src = fetchFromGitHub {
    owner = "qjcg";
    repo = "barr";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "18rpjcbw6w35hgjsih8gd1g5bf452w79bvfcaiqm1n81jl6zj95z" ;
  };

  subPackages = [ "cmd/barr" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  modSha256 = "085m3ypkkyav143mhw31fyvbwn8x00f27ypzmdg1k1qjggh40zy6" ;

  meta = with lib; {
    description = "A simple statusbar.";
    homepage = https://github.com/qjcg/barr;
    license = licenses.mit;
  };
}
