{ lib, buildGoModule, fetchFromGitHub, }:

with lib;

buildGoModule rec {
  pname = "rancher-cli";
  version = "2.4.7";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "cli";
    rev = "v${version}";
    sha256 = "sha256-eKRgI/7F/YPa2qy9sddHGF5CKfcGpshUL7xhcw54x7Y=";
  };

  subPackages = [ "." ];
  deleteVendor = true;
  vendorSha256 = "sha256-PNR1kK+Ad6nz2hVgB3SSyztSVhTkGfzdysevXe2M0ko=";
  buildFlagsArray = [ "-ldflags=-s -w -X main.VERSION=v${version}" ];

  postFixup = ''
    mv "$out"/bin/cli "$out"/bin/rancher
  '';

  meta = {
    description =
      "The Rancher Command Line Interface (CLI) is a unified tool for interacting with your Rancher Server.";
    homepage = "https://github.com/rancher/cli";
    license = licenses.asl20;
  };
}
