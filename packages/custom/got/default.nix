{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "got";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "melbahja";
    repo = "got";
    rev = "v${version}";
    sha256 = "1x1xaanh0w64qk4nn096w0nsnv0y8mb2j1v8b2ja408h7n5w6xx3";
  };

  vendorSha256 = "1nrm105r3zkp3pd1c0n65r97gvjqvv5n553ml3yf857libxlrjd3";
  subPackages = [ "cmd/got" ];

  meta = with stdenv.lib; {
    description = "Simple and fast concurrent downloader";
    homepage = "https://github.com/melbahja/got";
    license = licenses.mit;
  };
}
