{ lib, fetchFromGitHub, buildGoModule, }:
let
  inherit (lib) fakeSha256 licenses;
  version = "0.7.7";
in
buildGoModule {
  inherit version;
  pname = "git-repo";

  src = fetchFromGitHub {
    owner = "alibaba";
    repo = "git-repo-go";
    rev = "v${version}";
    sha256 = "sha256-SG0e1wztabfhVXjn01u72Lc6Yyxqiq8uc3r1GxB9r1g=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-rIk6qPJ3XSMgroHaMyxpjjUrejG/jlvNL7MwW/V2HzQ=";

  postFixup = ''
    mv $out/bin/git-repo-go $out/bin/git-repo
  '';

  meta = {
    description = "An easy-to-use solution for multiple repositories";
    homepage = "https://github.com/alibaba/git-repo-go";
    license = licenses.asl20;
  };
}
