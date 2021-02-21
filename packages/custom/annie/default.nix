{ lib, buildGoModule, fetchFromGitHub, }:
let
  inherit (lib) licenses;
  version = "0.10.3";
in
buildGoModule {
  inherit version;
  pname = "annie";

  src = fetchFromGitHub {
    owner = "iawia002";
    repo = "annie";
    rev = "${version}";
    sha256 = "sha256-Vp+Bwar/pPalobCJ2fzVSNtXGC6TnehKUq+DVTEkiS8=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-ovWBFCjrlQgf5Tdlbqj9ipsKAD/FRd/FChS4wefjAGU=";

  meta = {
    description = "Fast, simple and clean video downloader";
    homepage = "https://github.com/iawia002/annie";
    license = licenses.mit;
  };
}
