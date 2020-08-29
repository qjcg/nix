{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "got";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "melbahja";
    repo = "got";
    rev = "v${version}";
    sha256 = "0i4lsmi28lxrlwn6qiydx1l0ry89xlqvjqa1xdsvpzzfrcw9w82c";
  };

  vendorSha256 = "1w1c19vlq2ab5sf5gxsh55w9lj16g377q0vw691rpx6wl0k0ifps";
  subPackages = [ "cmd/got" ];

  meta = with stdenv.lib; {
    description = "Simple and fast concurrent downloader";
    homepage = "https://github.com/melbahja/got";
    license = licenses.mit;
  };
}
