{ stdenv, fetchFromGitHub, buildGoModule, installShellFiles }:

buildGoModule rec {
  pname = "k3d";
  version = "3.1.2";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";
    sha256 = "1qfmmglx57yhrrainxfrmmba54sgxj4is9fgpc3p5sr2babxqgnp";
  };

  deleteVendor = true;
  vendorSha256 = "14y3kr7dn1jzbfapjl3msz0kvahjfi5w9v0kqd0d81idrwj7b82s";

  subPackages = [ "." ];

  buildFlagsArray = [
    "-ldflags=-s -w"
    "-X github.com/rancher/k3d/v3/version.Version=${src.rev}"

    # Get this from https://update.k3s.io/v1-release/channels/stable
    "-X github.com/rancher/k3d/v3/version.K3sVersion=v1.18.9-k3s1"
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
