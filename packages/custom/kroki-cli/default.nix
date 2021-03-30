{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256;
  version = "0.4.0";
in
buildGoModule {
  inherit version;
  pname = "kroki-cli";

  src = fetchFromGitHub {
    owner = "yuzutech";
    repo = "kroki-cli";
    rev = "v${version}";
    sha256 = "sha256-sjokh1TnZEAgmTtYPYRiYby2waPGc1oj8zC4WX4HBJI=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-UMq48k/d7KiDmLKNwwJRMLFaPI9W4wHWyk0EabNmBJo=";

  meta = {
    description = "A CLI for https://kroki.io";
    homepage = "https://github.com/yuzutech/kroki-cli";
  };
}
