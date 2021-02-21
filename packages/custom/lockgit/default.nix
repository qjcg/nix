{ lib, buildGoModule, fetchFromGitHub, }:
let
  inherit (lib) fakeSha256 licenses;
  version = "0.9.0";
in
buildGoModule {
  inherit version;
  pname = "lockgit";

  src = fetchFromGitHub {
    owner = "jswidler";
    repo = "lockgit";
    rev = "v${version}";
    sha256 = "sha256-sVzAo3UdgznaEHovkr4Bi4onD+kcACU7kuq5fKNs0aI=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-iS23/qu0aMgW0EKSHjOUxnmmg1coMEKmC/2Q6tQ8EI0=";

  meta = {
    description = "A CLI tool for storing encrypted data in a git repo";
    homepage = "https://github.com/jswidler/lockgit";
    license = licenses.mit;
  };
}
