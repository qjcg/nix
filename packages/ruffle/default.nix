# NOTE: WIP, does not build yet!
{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "ruffle";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ruffle-rs";
    repo = pname;
    rev = "a472005f1be668a79f74a25ef86b893523797b6d";
    sha256 = "1kdn4v6jpwmdfai8sk6ylk7nhjvldrvczs910ncjijr7kg7b895w";
  };

  cargoSha256 = "0z9v7j5pw3l8gfsgbky0f0g4lzx49yxki88fg228lsz9vigs8p2b";

  meta = with stdenv.lib; {
    description = "A Flash Player emulator written in Rust";
    homepage = "https://github.com/ruffle-rs/ruffle";
    license = licenses.asl20;
  };
}
