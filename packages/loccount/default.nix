{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  fetchFromGitLab ? pkgs.fetchFromGitLab,
  buildGoPackage ? pkgs.buildGoPackage,
  ...
}:

buildGoPackage rec {
  name = "loccount-${version}";
  version = "2.7";

  goPackagePath = "gitlab.com/esr/loccount";

  src = fetchFromGitLab {
    owner = "esr";
    repo = "loccount";
    rev = "${version}";
    sha256 = "0pncxh7idzdpzyw8gipnnliszcqqvva9wd2yq8jkrfwaihiss5z3";
  };

  meta = with lib; {
    description = "Count source lines of code in a project.";
    homepage = https://gitlab.com/esr/loccount;
    license = licenses.bsd3;
    maintainers = [ { email = "john@gossetx.com"; github = "qjcg"; name = "John Gosset"; } ];
  };
}

