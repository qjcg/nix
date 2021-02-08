{ stdenv, buildGoModule, fetchFromGitHub, }:
let
  inherit (stdenv.lib) fakeSha256;
  version = "5.1";
in
buildGoModule {
  inherit version;
  pname = "mark";

  src = fetchFromGitHub {
    owner = "kovetskiy";
    repo = "mark";
    rev = "${version}";
    sha256 = "sha256-g5O68XB+95Wg7kwYYyGCxINKlJoMbQ+IcucVbsNNhvw=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-1YQD+QwCOAPOsj946DNF92LYKfRgXZXcfhIADP8s2CY=";

  meta = with stdenv.lib; {
    description =
      "The solution for syncing your Markdown docs with Atlassian Confluence.";
    homepage = "https://github.com/kovetskiy/mark";
    license = licenses.asl20;
  };
}
