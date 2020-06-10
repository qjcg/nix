{
  pkgs,
  lib,
  buildGoModule,
  fetchgit,
}:

buildGoModule rec {
  name = "brightness-${version}";
  version = "0.6.0";

  src = fetchgit {
    url = "git@git.jgosset.net:brightness";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "0000000000000000000000000000000000000000000000000000";

  meta = with lib; {
    description = "A CLI tool for adjusting screen brightness.";
    homepage = https://github.com/qjcg/brightness;
    license = licenses.mit;
  };
}
