{ stdenv, buildGoModule, fetchFromGitHub }:

let
  inherit (stdenv.lib) fakeSha256;
in
buildGoModule rec {
  pname = "rain";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "cenkalti";
    repo = "rain";
    rev = "v${version}";
    sha256 = "sha256-aM9/AzCjofQ7gN0wdMwuZoslWGCUnCtxUvoIUOaXE44=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-TMGWvGZKvZ2tsLEZ20mYVu3tA8/ldXEKAKrCa/UTFQg=";
  doCheck = false; # Tests seem to need root, disable for now.

  meta = with stdenv.lib; {
    description = "BitTorrent client and library in Go";
    homepage = "https://github.com/cenkalti/rain";
    license = licenses.mit;
  };
}
