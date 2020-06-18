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

  # NOTE 2020-06-18: BUILD FAILS if vendorSha256 is used in place of modSha256 below!?
  # See https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/go-modules/generic/default.nix
  modSha256 = "000knqwsajlqika4abp3fh721mn1vykcsnv3c1qw0mzffkmzwsqd";

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
    homepage = "https://github.com/kubernetes/helm";
    description = "A package manager for kubernetes";
    license = licenses.asl20;
    maintainers = with maintainers; [
      rlupton20
      edude03
      saschagrunert
      Frostman
    ];
  };
}
