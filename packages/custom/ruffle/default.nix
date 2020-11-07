{ stdenv
, fetchFromGitHub
, rustPlatform

, xorg
, autoconf
, automake
, bison
, pkgconfig
, libtool
, alsaLib
, python38
, openssl
, ...
}:

rustPlatform.buildRustPackage rec {
  pname = "ruffle";
  version = "nightly-2020-11-05";

  src = fetchFromGitHub {
    owner = "ruffle-rs";
    repo = pname;
    rev = "master";
    sha256 = "sha256-C+ZeHtJDqnoUyzP9o9ZhkCyJKXjVgMDfc+jv6DUzyCU=";
  };

  nativeBuildInputs = [ alsaLib autoconf automake bison pkgconfig libtool python38 ];

  buildInputs = with xorg; [ alsaLib libX11 openssl python38 ];

  cargoSha256 = "sha256-McSE1Enn33JWO5ovHeunWSAVXXSFRSq7+4lmzIE+ZRc=";

  meta = with stdenv.lib; {
    description = "A Flash Player emulator written in Rust";
    homepage = "https://github.com/ruffle-rs/ruffle";
    license = licenses.asl20;
  };
}
