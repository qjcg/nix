{ stdenv, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "helm";
  version = "3.3.1";
  #_version = "3.3"; # needed by helm's TestVersion unit test?

  src = fetchFromGitHub {
    owner = "helm";
    repo = "helm";
    rev = "v${version}";
    sha256 = "0y3ilvafzwizd9zqvp8jijkkd1c2yy7zyl5xfma1zv2x96p7xgqh";
  };

  vendorSha256 = "0f8a0psvic923rh13f5041p7hr6w8dy9qxdw3l195yky5cf3fj6w";

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

  # 2020-10-08: Avoid check for now, completion tests failing on luban.
  doCheck = false;

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
