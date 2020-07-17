{ stdenv, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "tekton-cli";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "tektoncd";
    repo = "cli";
    rev = "v${version}";
    sha256 = "1p0vjbfd8nrbdfh22g2yv8cljkzyamaphryf76i94cfi4245d9d7";
  };

  subPackages = [ "cmd/tkn" ];
  deleteVendor = true;
  vendorSha256 = "03vacm9yyvgc3q65b0cdkn74g070w8sqsj3splvv8npf34hn7nzf";

  buildFlagsArray =
    let t = "github.com/tektoncd/cli/pkg/cmd/version.clientVersion";
    in ''
      -ldflags= -s -w -X ${t}=v${version}
    '';

  nativeBuildInputs = [ installShellFiles ];
  postInstall = ''
    $out/bin/tkn completion bash > tkn.bash
    $out/bin/tkn completion zsh > tkn.zsh
    installShellCompletion tkn.{bash,zsh}
  '';

  meta = with stdenv.lib; {
    description = "A CLI for interacting with Tekton";
    homepage = "https://github.com/tektoncd/cli";
    license = licenses.asl20;
  };
}
