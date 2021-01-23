{ stdenv, fetchFromGitHub, buildGoModule, }:
let
  inherit (stdenv.lib) fakeSha256;
  version = "1.7.2";
in
buildGoModule {
  pname = "cm";
  version = version;

  src = fetchFromGitHub {
    owner = "aerokube";
    repo = "cm";
    rev = version;
    sha256 = "sha256-XG6pDFq859oQHcUQBOlUafX3yXRZ2+lFNNh+utqTkEU=";
  };

  vendorSha256 = "sha256-gShzJfhLeTmPDZ41Qr+glKfMVGS66UeUTKQih8aytM8=";

  # buildFlagsArray = [
  #   "-ldflags="
  #   "-X github.com/Jeffail/benthos/v3/lib/service.Version=${src.rev}"
  #   "-X github.com/Jeffail/benthos/v3/lib/service.DateBuilt=TimelessBuild"
  # ];

  subPackages = [ "." ];

  meta = with stdenv.lib; {
    description = "Configuration manager for Aerokube products";
    homepage = "https://github.com/aerokube/cm";
    license = licenses.asl20;
  };
}
