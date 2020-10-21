{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "jmigpin-editor";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "jmigpin";
    repo = "editor";
    rev = "v${version}";
    sha256 = "1vfb9ijbx6pfg51bqy77l9hrgsn1pvgh1m20cgq1316xibvnq08c";
  };

  subPackages = [ "." ];
  vendorSha256 = "18aa508wsls8g6dqlxzr1qj9lvlbcrs14s2wngavdc5dh9ffkhr0";

  meta = with stdenv.lib; {
    description = "Source code editor in pure Go";
    homepage = "https://github.com/jmigpin/editor";
    license = licenses.mit;
  };
}
