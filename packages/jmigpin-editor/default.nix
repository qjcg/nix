{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "jmigpin-editor";
  version = "2.0.7";

  src = fetchFromGitHub {
    owner = "jmigpin";
    repo = "editor";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "1xky3m69j1m0f8k4ar8v30k4sc51gwsnrhixx3f7zax5wz28jclm";
  };

  subPackages = [ "." ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "1vg1x2jbdg8b8qi3rnyxsb3cqp02qzh5y9lz4ml7bln47808wd0f";
  modRoot = "v2";

  meta = with stdenv.lib; {
    description = "Source code editor in pure Go";
    homepage = "https://github.com/jmigpin/editor";
    license = licenses.mit;
  };
}
