{ lib, fetchFromGitHub, buildGoModule, }:
let
  inherit (lib) licenses;
  version = "0.2.1";
in
buildGoModule {
  inherit version;
  pname = "k3c";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "k3c";
    rev = "v${version}";
    sha256 = "1ni7pab7hk9rkd7h4q7a6hcjdrsayqxfyj1jzvya0qra294flkkd";
  };

  subPackages = [ "." ];
  buildFlagsArray =
    let pkg = "github.com/rancher/k3c";
    in [ "-ldflags=-s -w -X ${pkg}/pkg/version.Version=v${version}" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  #vendorSha256 = lib.fakeSha256;
  deleteVendor = true;
  vendorSha256 = "0iiznjcx8r0v7mjbvry00cf4d4b52ngy036xm8fl3yx1kj0cqwfy";

  meta = {
    description =
      "Lightweight local container engine for container development";
    homepage = "https://github.com/rancher/k3c";
    license = licenses.asl20;
  };
}
