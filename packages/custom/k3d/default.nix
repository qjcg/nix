{ lib, fetchFromGitHub, buildGoModule, installShellFiles }:

with lib;
let
  # Get this from https://update.k3s.io/v1-release/channels/stable
  stableK3sVersionString = "v1.18.9-k3s1";
in
buildGoModule rec {
  pname = "k3d";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";
    sha256 = "sha256-kEsOToIxuWr7JdiuKvkS7E5HQdkn7W3txyDyujOiwEs=";
  };

  deleteVendor = true;
  vendorSha256 = "sha256-wjZT5cR5I/xLMA9z7TGKh0YFhUUMKrPU2RrGAoV6Omc=";

  subPackages = [ "." ];

  buildFlagsArray = [
    "-ldflags=-s -w"
    "-X github.com/rancher/k3d/v3/version.Version=${src.rev}"
    "-X github.com/rancher/k3d/v3/version.K3sVersion=${stableK3sVersionString}"
  ];

  nativeBuildInputs = [ installShellFiles ];
  postInstall = ''
    $out/bin/k3d completion bash > k3d.bash
    $out/bin/k3d completion zsh > k3d.zsh
    installShellCompletion k3d.{bash,zsh}
  '';

  meta = {
    description =
      "A lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker";
    homepage = "https://github.com/rancher/k3d";
    license = licenses.mit;
  };
}
