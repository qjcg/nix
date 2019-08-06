{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  name = "k3d-${version}";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0bdpjnzyxd6mdc1qv0ml89qds6305kn3wmyci2kv6g2y7r7wxvm2";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  #modSha256 = lib.fakeSha256;
  modSha256 = "1qadf3gc2626l4jpad4lzi649nh8if9m6fgs2cf46r1nish16h95";

  meta = with lib; {
    description = "Little helper to run Rancher Lab's k3s in Docker";
    homepage = https://github.com/rancher/k3d ;
    license = licenses.mit;
  };
}
