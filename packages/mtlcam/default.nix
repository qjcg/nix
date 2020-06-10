{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  name = "mtlcam-${version}";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "qjcg";
    repo = "mtlcam";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "07jl5iijs0r5jhyxsvrwvh613fj9ilsjkwbp1q53zg7ihp9ky9x8";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "11scb4mg8y8p0sldxdascngbc1w5v9hnpch54hjifcglf2hhi0fc";

  meta = with lib; {
    description = "Download Montreal traffic camera images.";
    homepage = https://github.com/qjcg/mtlcam;
    license = licenses.mit;
  };
}
