{ lib, fetchFromGitHub, buildGoModule, installShellFiles,

  # NOTE: K3s docker images use a "-k3s" suffix, while the k3d repo uses a "+k3d" suffix in git tags.
  # See also https://update.k3s.io/v1-release/channels/stable
  k3sVersion ? "v1.18.12-k3s2",
}:

with lib;
buildGoModule rec {
  pname = "k3d";
  version = "3.4.0";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";
    sha256 = "sha256-C4G4oWNgaKG/SrIAtGJ5YR5KrVr/+KduIMgadPZfOro=";
  };

  deleteVendor = true;
  vendorSha256 = "sha256-LR/elhBZ8vJR41TOYoXN5H+ZXMBu4WKLw8Y4yTWFZAc=";

  subPackages = [ "." ];

  buildFlagsArray = [
    "-ldflags=-s -w"
    "-X github.com/rancher/k3d/v3/version.Version=${src.rev}"
    "-X github.com/rancher/k3d/v3/version.K3sVersion=${k3sVersion}"
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
