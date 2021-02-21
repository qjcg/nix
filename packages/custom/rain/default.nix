{ lib, buildGoModule, fetchFromGitHub }:
let
  inherit (lib) fakeSha256 licenses;
  version = "1.6.0";
in
buildGoModule {
  inherit version;
  pname = "rain";

  src = fetchFromGitHub {
    owner = "cenkalti";
    repo = "rain";
    rev = "v${version}";
    sha256 = "sha256-aM9/AzCjofQ7gN0wdMwuZoslWGCUnCtxUvoIUOaXE44=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-TMGWvGZKvZ2tsLEZ20mYVu3tA8/ldXEKAKrCa/UTFQg=";
  doCheck = false; # Tests seem to need root, disable for now.

  meta = {
    description = "BitTorrent client and library in Go";
    homepage = "https://github.com/cenkalti/rain";
    license = licenses.mit;
  };
}
