{
  pkgs,
  lib ? pkgs.lib,
  fetchFromGitHub ? pkgs.fetchFromGitHub,
  buildGoModule ? pkgs.buildGoModule,
  ...
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
  modSha256 = "0w8q1ria631pl2wc0cnpcgk43ywvi15qij2nab46wd4cjsxd7z0r";

  meta = with lib; {
    description = "Download Montreal traffic camera images.";
    homepage = https://github.com/qjcg/mtlcam;
    license = licenses.mit;
    maintainers = [ { email = "john@gossetx.com"; github = "qjcg"; name = "John Gosset"; } ];
  };
}
