{ stdenv, buildGoModule, fetchFromGitHub, getopt, scdoc, }:

buildGoModule rec {
  pname = "maddy";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "foxcpp";
    repo = "maddy";
    rev = "v${version}";
    sha256 = "sha256-MGjLbm8MYvhgOndmF9mLyBkkM1OPcYQTl4g/9rO1PGk=";
  };

  vendorSha256 = "sha256-bzpfNlayhqym6TX9Sx+TKCY0KyF9TUS3VRiLaQ5yjKw=";
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

  meta = with stdenv.lib; {
    description = "Composable all-in-one mail server.";
    homepage = "https://github.com/foxcpp/maddy";
    license = licenses.gpl3;
  };
}
