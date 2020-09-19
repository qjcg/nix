{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "got";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "melbahja";
    repo = "got";
    rev = "v${version}";
    sha256 = "0nnw8k9rmgapq7md8wr4yd7gqngiag1ljwjck5wz62z3qx1dkys5";
  };

  vendorSha256 = "1nrm105r3zkp3pd1c0n65r97gvjqvv5n553ml3yf857libxlrjd3";
  subPackages = [ "cmd/got" ];

  meta = with stdenv.lib; {
    description = "Simple and fast concurrent downloader";
    homepage = "https://github.com/melbahja/got";
    license = licenses.mit;
  };
}
