{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub installShellFiles;
  inherit (pkgs.lib) fakeSha256 licenses;

  name = "blox";
  version = "0.5.1";
in
buildGoModule {
  inherit version;

  pname = name;

  src = fetchFromGitHub {
    owner = "cueblox";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-00SH5ALL26F5pWskWZmd6fqn8sp+j0mIl3JrFqahJGU=";
  };

  vendorSha256 = "sha256-gJ1vHvpqH3PunVXCXS0vKOkFCFfW1UBQ2/XS+AsB6MY=";
  subPackages = [ "cmd/blox" ];

  buildFlagsArray = [
    "-ldflags=-s -w"
    "-X main.Version=v${version}"
  ];

  nativeBuildInputs = [ installShellFiles ];
  postInstall = ''
    $out/bin/${name} completion bash > ${name}.bash
    $out/bin/${name} completion zsh > ${name}.zsh
    installShellCompletion ${name}.{bash,zsh}
  '';

  meta = {
    description = "";
    homepage = "https://github.com/cueblox/blox";
    license = licenses.mit;
  };
}
