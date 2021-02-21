{ lib, buildGoModule, fetchFromGitHub, }:
let
  inherit (lib) licenses;
  version = "1.0.2";
in
buildGoModule {
  inherit version;
  pname = "gohack";

  src = fetchFromGitHub {
    owner = "rogpeppe";
    repo = "gohack";
    rev = "v${version}";
    sha256 = "17fjfk7r0i4hnm1dkvlf9gxnl1jsnl1wnpa34wys3ggmnp7lil04";
  };

  vendorSha256 = "0h68vmxwfv71s20mm88m7i0ir6fah39m5ncch73gpfsv87477v88";

  # Added to build v1.0.2 due to some failing tests. The tool itself seems to
  # work fine regardless of the failing tests.
  doCheck = false;

  meta = {
    description = "Make temporary edits to your Go module dependencies";
    homepage = "https://github.com/rogpeppe/gohack";
    license = licenses.bsd3;
  };
}
