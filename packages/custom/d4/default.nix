{ lib, fetchFromGitHub, buildGoModule, }:
let
  inherit (lib) licenses;
  version = "0.5.5";
in
buildGoModule rec {
  inherit version;
  pname = "4d";

  src = fetchFromGitHub {
    owner = "qjcg";
    repo = "4d";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0nfdzgamjb127838xp3ald6vjwlvn080h5mhlb7zwrbw75bmxpql";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";

  meta = {
    description = "A simple CLI stopwatch.";
    homepage = "https://github.com/qjcg/4d";
    license = licenses.mit;
  };
}
