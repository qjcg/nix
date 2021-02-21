{ lib, fetchFromGitHub, buildGoModule, }:
let
  inherit (lib) licenses;
  version = "0.1.0";
in
buildGoModule {
  pname = "gled";

  src = fetchFromGitHub {
    owner = "karlovskiy";
    repo = "gled";
    rev = "85e9079c0eb9217afde826ee023d04ff59b053ea";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0mrxw4q1j48jhx94jq2dg8n7nqrp58gx4fs6jx55h4k8xji7pvrw";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "1yfziw4z4yjr9qzyp3vbxzzfkc7gzjn8fd5zfysqhxhsrn00q9rs";

  meta = {
    description = "Logitech G102 and G203 Prodigy Mouse LED control";
    homepage = "https://github.com/karlovskiy/gled";
    license = licenses.mit;
  };
}
