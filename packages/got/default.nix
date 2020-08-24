{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "got";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "melbahja";
    repo = "got";
    rev = "v${version}";
    sha256 = "sha256-FqUYFEBY6mJBwhsIxc0e2kSH1jRS24u8sUQbKPnplOY=";
  };

  vendorSha256 = "sha256-7Sp1yxUlranpp4XSocCknEsbOZgvOG6kGAFWSI0mwF4=";
  subPackages = [ "cmd/got" ];

  meta = with stdenv.lib; {
    description = "Simple and fast concurrent downloader";
    homepage = "https://github.com/melbahja/got";
    license = licenses.mit;
  };
}
