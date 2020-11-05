{ stdenv, buildGoModule, fetchFromGitHub, }:

buildGoModule rec {
  pname = "mark";
  version = "3.3.1";

  src = fetchFromGitHub {
    owner = "kovetskiy";
    repo = "mark";
    rev = "${version}";
    sha256 = "sha256-XMPzXXR33htWm0ptzAlzHFV4BNGQZhb1Fu2MV/vn+fc=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-Y1qoklqC0N0m1w0958jN0msUm5OVwD2ad0MaXoH/3jw=";

  meta = with stdenv.lib; {
    description =
      "The solution for syncing your Markdown docs with Atlassian Confluence.";
    homepage = "https://github.com/kovetskiy/mark";
    license = licenses.asl20;
  };
}
