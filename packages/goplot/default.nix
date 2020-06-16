{ stdenv, fetchFromGitHub, buildGoPackage, }:

buildGoPackage rec {
  pname = "goplot";
  # No tags, no releases, no go.mod file --- so just using latest hash from 2017.
  version = "9aef86e00152e2faec4e3b27aeed676fb8213c90";

  goPackagePath = "github.com/lebinh/goplot";
  subPackages = [ "." ];

  src = fetchFromGitHub {
    owner = "lebinh";
    repo = "goplot";
    rev = "${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "1d154nzg7srj3wnxgcmyrjbjpm9rihic38yf4rjs0l14sqm8fx7y";
  };

  meta = with stdenv.lib; {
    description = "Terminal-based stream plotting";
    homepage = "https://github.com/lebinh/goplot";
  };
}
