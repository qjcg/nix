{ stdenv, fetchFromGitHub, buildGoModule, installShellFiles }:

let
  # Get this from https://update.k3s.io/v1-release/channels/stable
  stableK3sVersionString = "v1.18.9-k3s1";
in buildGoModule rec {
  pname = "k3d";
  version = "3.1.5";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";
    sha256 = "0aspkar9im323d8117k48fvh1yylyspi2p2l2f5rdg1ilpa6hm53";
  };

  deleteVendor = true;
  vendorSha256 = "1sav3j2ha8wl58dzf510zs64rwv11k3vw184c243nvixs196xjd4";

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

  meta = with stdenv.lib; {
    description =
      "A lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker";
    homepage = "https://github.com/rancher/k3d";
    license = licenses.mit;
  };
}
