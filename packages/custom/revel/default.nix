{ licenses, buildGoModule, fetchFromGitHub }:
let
  inherit (lib) licenses;
  version = "1.0.0";
in
buildGoModule {
  pname = "revel";

  src = fetchFromGitHub {
    owner = "revel";
    repo = "cmd";
    rev = "v${version}";
    sha256 = "1dvsffxyr8w4v2352famqiacycmiq79f549h0igga0amvjsskdmd";
  };

  subPackages = [ "revel" ];
  vendorSha256 = "1iyvrjdz5p07c3yf8073szxwvd0g91pa6zflki3gfl1l6n2xg7rr";
  doCheck = false;

  meta = {
    description = "A high productivity, full-stack web framework";
    homepage = "http://revel.github.io/";
    license = licenses.mit;
  };
}
