{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256 licenses;
  version = "0.5.8";
in
buildGoModule {
  inherit version;
  pname = "earthly";

  src = fetchFromGitHub {
    owner = "earthly";
    repo = "earthly";
    rev = "v${version}";
    sha256 = "sha256-aFNOfJCsbelCAoTOOU555CqlbCFlLVMbiVPVpprBuXI=";
  };

  subPackages = [ "./cmd/earthly" ];
  vendorSha256 = "sha256-X4H869F6M7gfkbhf7Sik1G+07y3EOEL7oJyYv4iNxa0=";

  meta = {
    description = "Build automation for the container era";
    homepage = "https://github.com/earthly/earthly";
    license = licenses.bsl11;
  };
}
