{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub zstd;
  inherit (pkgs.lib) fakeSha256 licenses;
  version = "3.46.1";
in
buildGoModule {
  inherit version;
  pname = "benthos";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "sha256-CTK5AqBzXOZ58i8TbR/3B/BgDnvvE25oxKt+tY5WQl4=";
  };

  vendorSha256 = "sha256-vinvMAKW/xpP3ec8AiZBm5kRFGjR5Qx0+Tg+vcWyWl4=";

  buildFlagsArray = [
    "-ldflags="
    "-X github.com/Jeffail/benthos/v3/lib/service.Version=v${version}"
    "-X github.com/Jeffail/benthos/v3/lib/service.DateBuilt=ReproduciblyTimeless"
  ];

  buildInputs = [ zstd ];

  subPackages = [ "cmd/benthos" ];

  meta = {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
