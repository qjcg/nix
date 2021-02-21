{ lib, buildGoModule, fetchFromGitHub, }:
let
  inherit (builtins) fetchurl readFile;
  inherit (lib) licenses;
  # TODO: Add this to installed files.
  testScriptREADME = readFile (fetchurl "https://raw.githubusercontent.com/golang/go/master/src/cmd/go/testdata/script/README");
  version = "1.7.0";
in
buildGoModule {
  inherit version;
  pname = "go-internal";

  src = fetchFromGitHub {
    owner = "rogpeppe";
    repo = "go-internal";
    rev = "v${version}";
    sha256 = "sha256-F0/lpUvsvu2noqtrO05zQMkGOaN+6eS9w7JqY31bL1o=";
  };

  subPackages = [
    "cmd/testscript"
    "cmd/txtar-addmod"
    "cmd/txtar-c"
    "cmd/txtar-goproxy"
    "cmd/txtar-x"
  ];
  vendorSha256 = "sha256-Hbsi4Gsdql2conYjO3NvHRqNxNo7/1O05bsgw32VDDA=";

  doCheck = false;

  meta = {
    description = "Selected Go-internal packages factored out from the standard library";
    homepage = "https://github.com/rogpeppe/go-internal";
    license = licenses.bsd3;
  };
}
