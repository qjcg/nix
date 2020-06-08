{
  pkgs ? <nixpkgs>,
  lib ? pkgs.lib,
  fetchFromGitHub ? pkgs.fetchFromGitHub,
  buildGoModule ? pkgs.buildGoModule,
}:

buildGoModule rec {
  name = "benthos-${version}";
  version = "3.17.0";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0nfdz11111117838xp3ald6vjwlvn080h5mhlb7zwrbw75bmxpql";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "0sjjj9z1dh111118pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";

  meta = with lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = https://github.com/Jeffail/benthos;
    license = licenses.mit;
  };
}
