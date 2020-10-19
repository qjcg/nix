{ stdenv, buildGoModule, fetchFromGitHub, }:

buildGoModule rec {
  pname = "mark";
  version = "3.1";

  src = fetchFromGitHub {
    owner = "kovetskiy";
    repo = "mark";
    rev = "${version}";
    sha256 = "0s2crvq5y56j3b168n4cwzn5791b9ygf5wngya0abfkgwb8nns9c";
  };

  subPackages = [ "." ];
  vendorSha256 = "1lf7ngng7z5kp9qz2l923ivh83lh522225g4h9ljyndkkial4l0v";

  meta = with stdenv.lib; {
    description =
      "The solution for syncing your Markdown docs with Atlassian Confluence.";
    homepage = "https://github.com/kovetskiy/mark";
    license = licenses.asl20;
  };
}
