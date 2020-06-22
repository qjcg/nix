{ stdenv, buildGoModule, fetchFromGitHub, }:

buildGoModule rec {
  pname = "rancher-cli";
  version = "2.4.5";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "cli";
    rev = "v${version}";
    sha256 = "0a6is23bsxijcxklrxnq1l9fa23mkwypli5jaxwrcpp7zwxd5ihg";
  };

  subPackages = [ "." ];
  deleteVendor = true;
  vendorSha256 = "0gf7jaw9nzfkxdrl9k6v1mypqcsk3nrymj9x12d6d5b218k8kcgv";
  buildFlagsArray = [ "-ldflags=-s -w -X main.VERSION=v${version}" ];

  postFixup = ''
    mv "$out"/bin/cli "$out"/bin/rancher
  '';

  meta = with stdenv.lib; {
    description =
      "The Rancher Command Line Interface (CLI) is a unified tool for interacting with your Rancher Server.";
    homepage = "https://github.com/rancher/cli";
    license = licenses.asl20;
  };
}
