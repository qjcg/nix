{ stdenv, buildGoModule, fetchFromGitHub, Security }:

buildGoModule rec {
  pname = "revel";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "revel";
    repo = "cmd";
    rev = "v${version}";
    sha256 = "1dvsffxyr8w4v2352famqiacycmiq79f549h0igga0amvjsskdmd";
  };

  buildInputs = stdenv.lib.optional stdenv.isDarwin Security;

  subPackages = [ "revel" ];
  deleteVendor = true;
  vendorSha256 = "1iyvrjdz5p07c3yf8073szxwvd0g91pa6zflki3gfl1l6n2xg7rr";

  meta = with stdenv.lib; {
    description = "A high productivity, full-stack web framework";
    homepage = "http://revel.github.io/";
    license = licenses.mit;
  };
}
