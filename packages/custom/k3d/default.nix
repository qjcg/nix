{ pkgs
, # NOTE: K3s docker images use a "-k3s" suffix, while the k3d repo uses a "+k3d" suffix in git tags.
  # See also https://update.k3s.io/v1-release/channels/stable
  # (version selected here should correspond to the k8s version used in prod)
  k3sVersion ? "v1.18.6-k3s1"
}:
let
  inherit (pkgs) buildGoModule fetchFromGitHub installShellFiles;
  inherit (pkgs.lib) fakeSha256 licenses;
  version = "4.4.3";
in
buildGoModule {
  inherit version;

  pname = "k3d";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";
    sha256 = "sha256-G8oaJtfsbSi5WaJobxUpNu9DchHfzbkpPvq23GYM99s=";
  };

  vendorSha256 = null; # Use k3d's vendor directory.
  subPackages = [ "." ];

  buildFlagsArray = [
    "-ldflags=-s -w"
    "-X github.com/rancher/k3d/v4/version.Version=v${version}"
    "-X github.com/rancher/k3d/v4/version.K3sVersion=${k3sVersion}"
  ];

  nativeBuildInputs = [ installShellFiles ];
  postInstall = ''
    $out/bin/k3d completion bash > k3d.bash
    $out/bin/k3d completion zsh > k3d.zsh
    installShellCompletion k3d.{bash,zsh}
  '';

  meta = {
    description =
      "A lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker";
    homepage = "https://github.com/rancher/k3d";
    license = licenses.mit;
  };
}
