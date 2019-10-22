{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  name = "horeb-${version}";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "qjcg";
    repo = "horeb";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0ss84xfrjz9mljg84n8dwx8bcp8drnngmscf150knp3z8cc8sr8z";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  modSha256 = "1dvr61wkxh4jfskw9k427qb4wwy01mr12q9f4d5pi106d9j9d3hd";

  meta = with lib; {
    description = "Speaking in tongues via stdout.";
    homepage = https://github.com/qjcg/horeb;
    license = licenses.mit;
  };
}
