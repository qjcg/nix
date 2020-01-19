{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "skaffold";
  version = "1.1.0";
  # rev is the 1.1.0 commit, mainly for skaffold version command output
  rev = "2f14d99fc5f81e3a52dd76d43cad8d014f150327";

  goPackagePath = "github.com/GoogleContainerTools/skaffold";
  subPackages = ["cmd/skaffold"];

  buildFlagsArray = let t = "${goPackagePath}/pkg/skaffold"; in  ''
    -ldflags=
      -X ${t}/version.version=v${version}
      -X ${t}/version.gitCommit=${rev}
      -X ${t}/version.buildDate=unknown
  '';

  src = fetchFromGitHub {
    owner = "GoogleContainerTools";
    repo = "skaffold";
    rev = "v${version}";
    sha256 = "1a4gkr0g620d4hxfxzk2aasic91assgwf0flms8av2nm2pkcv7yw";
  };

  meta = {
    description = "Easy and Repeatable Kubernetes Development";
    homepage = https://github.com/GoogleContainerTools/skaffold;
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ vdemeester ];
  };
}
