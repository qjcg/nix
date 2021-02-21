{ lib, buildGoModule, fetchFromGitHub, getopt, scdoc, }:
let
  inherit (lib) licenses;
  version = "0.4.3";
in
buildGoModule {
  inherit version;
  pname = "maddy";

  src = fetchFromGitHub {
    owner = "foxcpp";
    repo = "maddy";
    rev = "v${version}";
    sha256 = "sha256-Z4dO5lta51TnCeYo/DLNd/m7XYLc07J7Tz4xQuEBJtY=";
  };

  vendorSha256 = "sha256-Z3MtcqRYRsZFIi5+vxqD4lr79PDNaLynij6hQwxyipo=";
  subPackages = [ "cmd/maddy" "cmd/maddyctl" ];

  nativeBuildInputs = [ getopt scdoc ];
  postBuild = ''
    for f in docs/man/*.scd; do
      scdoc < $f > ''${f%%.scd}
    done
  '';

  installPhase = ''
    install -Dm555 $GOPATH/bin/maddy $GOPATH/bin/maddyctl -t $out/bin
    install -Dm640 maddy.conf -t $out/etc/maddy
    install -Dm644 dist/systemd/* -t $out/lib/systemd/system
    install -Dm644 docs/man/*.1 -t $out/share/man/man1
    install -Dm644 docs/man/*.5 -t $out/share/man/man5
  '';

  meta = {
    description = "Composable all-in-one mail server.";
    homepage = "https://github.com/foxcpp/maddy";
    license = licenses.gpl3;
  };
}
