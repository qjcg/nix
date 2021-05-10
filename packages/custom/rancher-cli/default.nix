{ pkgs, lib, buildGoModule, fetchFromGitHub, }:

with lib;

let
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256 licenses;

  version = "2.4.11";
in
buildGoModule rec {
  inherit version;
  pname = "rancher-cli";


  src = fetchFromGitHub {
    owner = "rancher";
    repo = "cli";
    rev = "v${version}";
    sha256 = "sha256-PhI+1xSdkXqREJPq7JjsmnnZY1D5b1NxaHnoxAa7vxM=";
  };

  subPackages = [ "." ];
  vendorSha256 = "sha256-/etX/SFoaze2ZVp6XLypgEfQ22R/tD1xNwuTTvvvPw8=";
  buildFlagsArray = [ "-ldflags=-s -w -X main.VERSION=v${version}" ];

  postFixup = ''
    mv "$out"/bin/cli "$out"/bin/rancher
  '';

  meta = {
    description =
      "The Rancher Command Line Interface (CLI) is a unified tool for interacting with your Rancher Server.";
    homepage = "https://github.com/rancher/cli";
    license = licenses.asl20;
  };
}
