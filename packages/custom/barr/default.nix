{ lib, fetchFromGitHub, buildGoModule, }:
let
  inherit (lib) licenses;
  version = "1.14.17-alpha";
in
buildGoModule {
  inherit version;
  pname = "barr";

  src = fetchFromGitHub {
    owner = "qjcg";
    repo = "barr";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "195fs1khh9q588qgzd4j11frl5irh3092chqiz437ydwfpbgxy7h";
  };

  buildFlagsArray = [ "-ldflags=-s -w -X main.Version=v${version}" ];

  subPackages = [ "cmd/barr" ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "0sy9q0nimmlripnv8848gizkh594k8hq0yqxiampmkr8xgdh4wdc";

  meta = {
    description = "A simple statusbar";
    homepage = "https://github.com/qjcg/barr";
    license = licenses.mit;
  };
}
