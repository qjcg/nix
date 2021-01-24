{ pkgs, buildGoModule, fetchFromGitHub, ... }:
let
  inherit (pkgs.stdenv.lib) fakeSha256;
  inherit (pkgs.stdenv.lib.licenses) mit;

  version = "0.6.0";
in
buildGoModule {
  pname = "brightness";
  version = version;

  src = fetchFromGitHub {
    owner = "qjcg";
    repo = "brightness";
    rev = "v${version}";
    sha256 = "sha256-ptb/N8iF0RSEZb/q2G1PeWN/q3cS0frk7k6NFCUvCsw=";
  };

  vendorSha256 = "sha256-pQpattmS9VmO3ZIQUFn66az8GSmB4IvYhTTCFn6SUmo=";

  meta = {
    description = "A CLI tool for adjusting screen brightness";
    homepage = "https://github.com/qjcg/brightness";
    license = mit;
  };
}
