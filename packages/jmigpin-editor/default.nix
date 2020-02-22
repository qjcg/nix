{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  name = "jmigpin-editor-${version}";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "jmigpin";
    repo = "editor";
    rev = "v${version}";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "155cr42pzxwjy756hrys8wbmghd690fn2m1gfys8wxfca4knjlq4";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  modSha256 = "00xwzi31cg114p18fpdl13dx1z546v0566hp6mjsfcm9j2mynhax";

  meta = with lib; {
    description = "Source code editor in pure Go.";
    homepage = https://github.com/jmigpin/editor;
    license = licenses.mit;
  };
}
