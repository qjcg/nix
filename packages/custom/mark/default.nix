{ stdenv, buildGoModule, fetchFromGitHub, }:

buildGoModule rec {
  pname = "mark";
  version = "3.5";

  src = fetchFromGitHub {
    owner = "kovetskiy";
    repo = "mark";
    rev = "${version}";
    sha256 = "sha256-SyzAnuTVti1rykdz0A8UJZ+HxGgNhtwddW9krJiwRH0=";
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
