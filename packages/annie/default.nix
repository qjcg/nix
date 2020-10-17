{ stdenv, buildGoModule, fetchFromGitHub, }:

buildGoModule rec {
  pname = "annie";
  version = "0.10.3";

  src = fetchFromGitHub {
    owner = "iawia002";
    repo = "annie";
    rev = "${version}";
    sha256 = "sha256-Vp+Bwar/pPalobCJ2fzVSNtXGC6TnehKUq+DVTEkiS8=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-ovWBFCjrlQgf5Tdlbqj9ipsKAD/FRd/FChS4wefjAGU=";

  meta = with stdenv.lib; {
    description = "Fast, simple and clean video downloader";
    homepage = "https://github.com/iawia002/annie";
    license = licenses.mit;
  };
}
