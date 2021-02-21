{ lib, buildGoModule, fetchFromGitHub, }:
let
  inherit (lib) fakeSha256 licenses;
  version = "5.2";
in
buildGoModule {
  inherit version;
  pname = "mark";

  src = fetchFromGitHub {
    owner = "kovetskiy";
    repo = "mark";
    rev = "${version}";
    sha256 = "sha256-bjDQwtIsY+Dvv270DACvyU+MNPyI7EZcob6F/aebVac=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-l6zHsis2fais5HQJQdfsSC0sPdcF4BeWoUznpl3Fh1g=";

  meta = {
    description =
      "The solution for syncing your Markdown docs with Atlassian Confluence.";
    homepage = "https://github.com/kovetskiy/mark";
    license = licenses.asl20;
  };
}
