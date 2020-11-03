{ stdenv, buildGoModule, fetchFromGitHub, }:

buildGoModule rec {
  pname = "mark";
  version = "3.3";

  src = fetchFromGitHub {
    owner = "kovetskiy";
    repo = "mark";
    rev = "${version}";
    sha256 = "sha256-BvM9D3o1qPKrQZTUf1tu1OeC16eaoFE9bEVai3ScTDc=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-vDkL7Eel1D/n7X5NAM1n9DWhA1V3daeMmRuVsT0pKfY=";

  meta = with stdenv.lib; {
    description =
      "The solution for syncing your Markdown docs with Atlassian Confluence.";
    homepage = "https://github.com/kovetskiy/mark";
    license = licenses.asl20;
  };
}
