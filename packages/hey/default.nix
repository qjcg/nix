{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "hey";
  version = "0.1.2";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "rakyll";
    repo = "hey";
    sha256 = "02p0gaf28gbfg7kixm35yn1bbzv6pr28bhjbp4iz9qd5221hfpbj";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  modSha256 = "0a00kcyagqczw0vhl8qs2xs1y8myw080y9kjs4qrcmj6kibdy55q";

  meta = with stdenv.lib; {
    description = "HTTP load generator";
    homepage = https://github.com/rakyll/hey;
    license = licenses.asl20;
  };
}
