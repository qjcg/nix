{
  pkgs ? import <nixpkgs> {},
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
    sha256 = "1ygf5crv5sp9sr30qhqnbxc65s36xfx1c721sp7xhw3r9qja6d05";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "1s0p3glszr81wxk0h38n55zcpzchacrnwr725jk4jqdpfifrn1qk";

  meta = with lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = https://github.com/Jeffail/benthos;
    license = licenses.mit;
  };
}
