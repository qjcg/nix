{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  name = "k3d-${version}";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0dbyyzyprhxsq6ardq380hppzdg01crppad5fczzlqsaxxvac039";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  #modSha256 = lib.fakeSha256;
  modSha256 = "1xp5q21nsc920hqy28k514g4s3mwp5462lmdl6b60lfhlaf23940";

  meta = with lib; {
    description = "Little helper to run Rancher Lab's k3s in Docker";
    homepage = https://github.com/rancher/k3d ;
    license = licenses.mit;
  };
}
