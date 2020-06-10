{
  pkgs,
  lib,
  fetchFromGitHub,
  buildGoModule,
}:

buildGoModule rec {
  name = "pms-${version}";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "ambientsound";
    repo = "pms";
    rev = "0f72e8e6bcbf1a05642eddd5f03d965e47263f12";

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "1j2m5f2jibv7xig5csvzngkcrq1hcm36f9k6l1mhcrq0khqbngmm";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "19wc5q7009j8h7sasvm9jvql9zbhjxgdpjwsay99jlbzsm23dkcn";

  meta = with lib; {
    description = "Practical Music Search is an interactive Vim-like console client for the Music Player Daemon."; 
    homepage = https://ambientsound.github.io/pms/;
    license = licenses.mit;
  };
}
