{ stdenv, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "helm";
  version = "3.2.4";

  src = fetchFromGitHub {
    owner = "helm";
    repo = "helm";
    rev = "v${version}";
    sha256 = "1plpk8qnv11d47qz93h57abjchyp6ahgyazyp0c6rv24vb9fp9zi";
  };

  modSha256 = "000knqwsajlqika4abp3fh721mn1vykcsnv3c1qw0mzffkmzwsqd";
  vendorSha256 = null;

  subPackages = [ "cmd/helm" ];
  buildFlagsArray = [
    "-ldflags=-w -s -X helm.sh/helm/v3/internal/version.version=v${version}"
  ];

  nativeBuildInputs = [ installShellFiles ];
  postInstall = ''
    $out/bin/helm completion bash > helm.bash
    $out/bin/helm completion zsh > helm.zsh
    installShellCompletion helm.{bash,zsh}
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/helm/helm";
    description = "The Kubernetes Package Manager";
    license = licenses.asl20;
    maintainers = with maintainers; [
      rlupton20
      edude03
      saschagrunert
      Frostman
    ];
  };
}
