{ pkgs }:
let
  inherit (builtins) fetchurl readFile;
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256 licenses;
  # TODO: Add this to installed files.
  testScriptREADME = readFile (fetchurl "https://raw.githubusercontent.com/golang/go/master/src/cmd/go/testdata/script/README");
  version = "1.8.0";
in
buildGoModule {
  inherit version;
  pname = "go-internal";

  src = fetchFromGitHub {
    owner = "rogpeppe";
    repo = "go-internal";
    rev = "v${version}";
    sha256 = "sha256-ze+/FkW3z3b+frAksjWPjDolP1UtSf6z0By6PGXTirM";
  };

  subPackages = [
    "cmd/testscript"
    "cmd/txtar-addmod"
    "cmd/txtar-c"
    "cmd/txtar-goproxy"
    "cmd/txtar-x"
  ];
  vendorSha256 = "sha256-8PtUfkboSAm5EFvWWbkf2uenITQTMrb4DTvF0F/NTDU=";

  doCheck = false;

  meta = {
    description = "Selected Go-internal packages factored out from the standard library";
    homepage = "https://github.com/rogpeppe/go-internal";
    license = licenses.bsd3;
  };
}
