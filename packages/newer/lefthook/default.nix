{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256 licenses maintainers;

  version = "0.7.4";
in

buildGoModule {
  inherit version;
  pname = "lefthook";

  src = fetchFromGitHub {
    rev = "master";
    owner = "Arkweid";
    repo = "lefthook";
    sha256 = "sha256-wW8Obh0YmAZHKrXLQ8364+TrAmLIYKRir2qXdWLtVkE=";
  };

  vendorSha256 = "sha256-XR7xJZfgt0Hx2DccdNlwEmuduuVU8IBR0pcIUyRhdko=";

  doCheck = false;

  meta = {
    description = "Fast and powerful Git hooks manager for any type of projects";
    homepage = "https://github.com/Arkweid/lefthook";
    license = licenses.mit;
    maintainers = with maintainers; [ rencire ];
  };
}
