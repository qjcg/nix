{ stdenv, buildGoModule, fetchFromGitHub, }:
let
  inherit (stdenv.lib) fakeSha256;
in
buildGoModule rec {
  pname = "mark";
  version = "4.1";

  src = fetchFromGitHub {
    owner = "kovetskiy";
    repo = "mark";
    rev = "${version}";
    sha256 = "sha256-eyzLw6oJSKk8X7jOEpVEIldavQUX5qJ+xEhfLFkHous=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-Fbj0jqAURkSiFBitkX8LPP1e0ln5HB7lw8KPVR77ccM=";

  meta = with stdenv.lib; {
    description =
      "The solution for syncing your Markdown docs with Atlassian Confluence.";
    homepage = "https://github.com/kovetskiy/mark";
    license = licenses.asl20;
  };
}
