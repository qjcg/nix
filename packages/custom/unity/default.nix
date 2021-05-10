{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256 licenses;

  name = "unity";
  version = "081a4bc6118c51ec8d94c350dffe9eb1ab07585e";
in
buildGoModule {
  inherit version;

  pname = name;

  src = fetchFromGitHub {
    owner = "cue-sh";
    repo = name;
    rev = version;
    sha256 = "sha256-Gp9xE1+T7idqPIU0MIvD3n4pAXF0TCrKW9lGsf7B+js=";
  };

  vendorSha256 = "sha256-qworfK6/Umq5p2qloSOudjK6vmMJ/GfrbJamxUsPkQs=";
  subPackages = [ "cmd/${name}" ];

  meta = {
    description = "Run experiments/regression tests on CUE modules";
    homepage = "https://github.com/cue-sh/unity";
    license = licenses.asl20;
  };
}
