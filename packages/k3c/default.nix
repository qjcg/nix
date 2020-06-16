{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "k3c";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "ibuildthecloud";
    repo = "k3c";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0z22vixg14bqs04dfb7qhjlc94v8x97hv9kgqzab7lz95xcf0mqb";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  #vendorSha256 = lib.fakeSha256;
  vendorSha256 = "0wgx3jlw92bzwcbwqbq3hrv4q1z2mzrvxnld6bj5rgkwym1f8zvs";

  meta = with stdenv.lib; {
    description =
      "Lightweight local container engine for container development";
    homepage = "https://github.com/ibuildthecloud/k3c";
    license = licenses.asl20;
  };
}
