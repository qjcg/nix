{
  lib,
  fetchFromGitHub,
  buildGoModule,
  writeTextFile,

  pkgconfig,
  glfw, mesa, openal,
  libX11, libXcursor, libXrandr, libXinerama,
  libXi, libXxf86vm,
}:

buildGoModule rec {
  name = "ludo-${version}";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "libretro";
    repo = "ludo";
    rev = "v${version}";
    fetchSubmodules = true;

    # To get this value, use "nix-prefetch-url --unpack" with the release tarball, eg:
    #   nix-prefetch-url --unpack https://github.com/qjcg/4d/archive/v0.5.5.tar.gz
    sha256 = "0fifvbmxsbqrgmigiqq565nm1wm10lidndqrdccq40aq3jn2h27n";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [
    glfw
    openal

    libX11
    libXcursor
    libXrandr
    libXinerama

    libXi
    libXxf86vm
  ];

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  #modSha256 = lib.fakeSha256;
  modSha256 = "1qx2k82lyyikv5nx7n7agd5k5az9lkjhfiwwk755smyzk3cypb9z";

  subPackages = [ "." ];

  patches = [
    ./01_add-conf-file.patch
    ./02_fix-settings-locations.patch
  ] ;

  # Ref: https://nixos.org/nixpkgs/manual/#ssec-stdenv-functions
  postPatch = ''
    substituteAllInPlace ludo.json
    substituteAllInPlace settings/defaults.go
    substituteAllInPlace settings/settings.go
  '';

  postInstall = ''
    # Copy config file pointing to static file locations.
    install -Dm644 ludo.json "$out"/etc/ludo.json

    # Copy static files.
    mkdir -p "$out"/share/ludo
    # FIXME: Copy cores as well --- but how?
    cp -r $src/assets $src/database "$out"/share/ludo/
  '';

  meta = {
    description = "A minimalist libretro frontend written in golang";
    homepage = https://github.com/libretro/ludo ;
    license = lib.licenses.gpl3;
    maintainers = [ { email = "john@gossetx.com"; github = "qjcg"; name = "John Gosset"; } ];
  };
}
