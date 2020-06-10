{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "hey";
  version = "0.1.3";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "rakyll";
    repo = "hey";
    sha256 = "06w5hf0np0ayvjnfy8zgy605yrs5j326nk2gm0fy7amhwx1fzkwv";
  };

  # First, provide a fake hash via the value: lib.fakeSha256
  # Then, during build, copy "got" value in here.
  # Ref: https://discourse.nixos.org/t/how-to-create-modsha256-for-buildgomodule/3059/2
  vendorSha256 = "0a00kcyagqczw0vhl8qs2xs1y8myw080y9kjs4qrcmj6kibdy55q";

  meta = with stdenv.lib; {
    description = "HTTP load generator";
    homepage = https://github.com/rakyll/hey;
    license = licenses.asl20;
  };
}
