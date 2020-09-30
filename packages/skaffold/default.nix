{ stdenv, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "skaffold";
  version = "1.15.0";

  src = fetchFromGitHub {
    owner = "GoogleContainerTools";
    repo = "skaffold";
    rev = "v${version}";
    sha256 = "0cir9ld61pq1rziw6vyz1ihkq0aylzrsxg1vqb9544rwnbq7z2qs";
  };

  deleteVendor = true;
  vendorSha256 = "0i31jydgp7j7yqh1z9j8fc5rhwn9sqvq597ybbrgc7yr7pd2i53g";
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
