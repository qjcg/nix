{ stdenv, fetchFromGitHub, buildGoModule, installShellFiles
, k3sVersion ? "v1.18.6-k3s1" }:

buildGoModule rec {
  pname = "k3d";
  version = "3.0.1";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "1l6mh0dpf2bw9sxpn14iivv3pr8mj4favzx2hhn8k1j71cm1w4rj";
  };

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

  deleteVendor = true;
  vendorSha256 = "14y3kr7dn1jzbfapjl3msz0kvahjfi5w9v0kqd0d81idrwj7b82s";

  meta = with stdenv.lib; {
    description =
      "A lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker";
    homepage = "https://github.com/rancher/k3d";
    license = licenses.mit;
  };
}
