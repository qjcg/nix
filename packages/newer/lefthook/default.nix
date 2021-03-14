{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256 licenses maintainers;

  version = "0.7.2-dev";
in

buildGoModule {
  inherit version;
  pname = "lefthook";

  src = fetchFromGitHub {
    rev = "master";
    owner = "Arkweid";
    repo = "lefthook";
    sha256 = "sha256-ciROP7CnnwVnwSMM1imh3R9cFeKNQVImRHBJKODO7f0=";
  };

  vendorSha256 = "sha256-P0xZxTiIS2D39iggbk0ugkJj2sVDbv1Gd3dl8J/tVuA=";

  doCheck = false;

  meta = {
    description = "Fast and powerful Git hooks manager for any type of projects";
    homepage = "https://github.com/Arkweid/lefthook";
    license = licenses.mit;
    maintainers = with maintainers; [ rencire ];
  };
}
