{ pkgs }:
let
  inherit (pkgs) buildGoModule fetchFromGitHub;
  inherit (pkgs.lib) fakeSha256 licenses;
  version = "3.44.0";
in
buildGoModule {
  inherit version;
  pname = "benthos";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "sha256-a4461ilinCAR3qQduB7R8wumCcM93oT0GFyL6BrK2C0=";
  };

  vendorSha256 = "sha256-argcVPV33ql3jhd8CmmqmVYVuWdoNYMdTX/5ZSBZUj8=";

  buildFlagsArray = [
    "-ldflags="
    "-X github.com/Jeffail/benthos/v3/lib/service.Version=v${version}"
    "-X github.com/Jeffail/benthos/v3/lib/service.DateBuilt=ReproduciblyTimeless"
  ];

  subPackages = [ "cmd/benthos" ];

  meta = {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
