{ fetchFromGitHub, buildGoPackage, }:
let
  version = "9aef86e00152e2faec4e3b27aeed676fb8213c90";
in
buildGoPackage {
  inherit version;
  pname = "goplot";
  # No tags, no releases, no go.mod file --- so just using latest hash from 2017.

  goPackagePath = "github.com/lebinh/goplot";
  subPackages = [ "." ];

  src = fetchFromGitHub {
    owner = "lebinh";
    repo = "goplot";
    rev = "${version}";
    sha256 = "1d154nzg7srj3wnxgcmyrjbjpm9rihic38yf4rjs0l14sqm8fx7y";
  };

  meta = {
    description = "Terminal-based stream plotting";
    homepage = "https://github.com/lebinh/goplot";
  };
}
