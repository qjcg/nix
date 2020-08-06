{ stdenv, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "skaffold";
  version = "1.13.1";

  src = fetchFromGitHub {
    owner = "GoogleContainerTools";
    repo = "skaffold";
    rev = "v${version}";
    sha256 = "1v6napcpx8k45s8w55lbxahfc1p0qlvl597zgb4dzyg9w67fwnqk";
  };

  deleteVendor = true;
  vendorSha256 = "19k6i7sfxvpqmrcv6xiv806xgxhchpq01ykkzl3sdji36jwqcwsz";
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
