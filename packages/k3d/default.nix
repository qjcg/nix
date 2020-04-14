{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
  stdenv,
  darwin,
}:

buildGoModule rec {
  name = "k3d-${version}";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0aij2l7zmg4cxbw7pwf7ddc64di25hpjvbmp1madhz9q28rwfa9w";
  };

  # Ref: https://github.com/tsaeger/nixpkgs/commit/39386e9f81552720468acd0eb35becec863c0e37
  buildInputs = []
  ++ stdenv.lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  #modSha256 = lib.fakeSha256;
  modSha256 = "0c8bfl0hz5cfhi6jzhhylz051jiix6s7s20fn23w7wri4xaqrjn8";

  meta = with lib; {
    description = "Little helper to run Rancher Lab's k3s in Docker";
    homepage = https://github.com/rancher/k3d ;
    license = licenses.mit;
  };
}
