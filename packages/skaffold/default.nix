{ stdenv, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "skaffold";
  version = "1.11.0";

  src = fetchFromGitHub {
    owner = "GoogleContainerTools";
    repo = "skaffold";
    rev = "v${version}";
    sha256 = "035xp34m8kzb75mivgf3kw026n2h6g2a7j2mi32nxl1a794w36zi";
  };

  deleteVendor = true;
  vendorSha256 = "1s5747b1zcl1g4zxbqya3ma1a52kkiw33j9h73r05r9kgashx2l4";
  subPackages = [ "cmd/skaffold" ];

  buildFlagsArray =
    let t = "github.com/GoogleContainerTools/skaffold/pkg/skaffold/version";
    in ''
      -ldflags= -s -w -X ${t}.version=v${version}
    '';

  nativeBuildInputs = [ installShellFiles ];
  postInstall = ''
    $out/bin/skaffold completion bash > skaffold.bash
    $out/bin/skaffold completion zsh > skaffold.zsh
    installShellCompletion skaffold.{bash,zsh}
  '';

  meta = with stdenv.lib; {
    description = "Easy and Repeatable Kubernetes Development";
    homepage = "https://github.com/GoogleContainerTools/skaffold";
    license = licenses.asl20;
    maintainers = with maintainers; [ vdemeester ];
  };
}
