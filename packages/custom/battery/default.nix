{ pkgs, lib, fetchFromGitHub, buildGoPackage, }:

buildGoPackage rec {
  name = "battery-${version}";
  version = "0.9.0";

  goPackagePath = "github.com/distatus/battery";
  subPackages = [ "cmd/battery" ];

  src = fetchFromGitHub {
    owner = "distatus";
    repo = "battery";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0ans60lwzgd52cisjq79zpmnmzd92xc619rf4j0pqi0w7wjivslf";
  };

  meta = with lib; {
    description = "Cross-platform, normalized battery information tool";
    homepage = "https://github.com/distatus/battery";
    license = licenses.mit;
  };
}
