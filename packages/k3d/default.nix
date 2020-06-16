{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "k3d";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3d";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0aij2l7zmg4cxbw7pwf7ddc64di25hpjvbmp1madhz9q28rwfa9w";
  };

  buildFlagsArray =
    [ "-ldflags=-s -w -X github.com/rancher/k3d/version.Version=${version}" ];

  deleteVendor = true;

  meta = with stdenv.lib; {
    description =
      "A lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker";
    homepage = "https://github.com/rancher/k3d";
    license = licenses.mit;
  };
}
