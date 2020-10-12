{ stdenv, buildGoModule, fetchFromGitHub, }:

buildGoModule rec {
  pname = "grafterm";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "slok";
    repo = "grafterm";
    rev = "v${version}";
    sha256 = "0nkmpg74gdnhf0rcdfa9pxwzqa51hrb9j9d0sk7izhr6n3m3g4yj";
  };

  subPackages = [ "cmd/grafterm" ];
  vendorSha256 = "00ni6g3pc02v83a0j6qqdls8kfhmp3vh660gcq91jhh0mw3kks5x";

  buildFlagsArray = ''
    -ldflags= -s -w -X main.Version=${version}
  '';

  meta = with stdenv.lib; {
    description =
      "Metrics dashboards on terminal (a grafana inspired terminal version)";
    homepage = "https://github.com/slok/grafterm";
    license = licenses.asl20;
  };
}
