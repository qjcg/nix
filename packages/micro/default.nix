{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "micro";
  version = "2.9.3";

  src = fetchFromGitHub {
    owner = "micro";
    repo = "micro";
    rev = "v${version}";
    sha256 = "0bwv3xbb442pr95x2n7s60wc5cfw531jq3q9ikcnxbhrp217mi02";
  };

  subPackages = [ "." ];
  vendorSha256 = "0jm3shz027mqnn6xjxz55c1vxxzb7fjrdbbn0zqyx5bx3wpxyj57";

  meta = with stdenv.lib; {
    description = "A framework for cloud-native development";
    homepage = "http://micro.mu";
    license = licenses.asl20;
  };
}
