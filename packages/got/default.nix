{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "got";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "melbahja";
    repo = "got";
    rev = "v${version}";
    sha256 = "0nszxr25byps46rj8k3xk8xkd81dv83ckdr747idjsx0mi432vdn";
  };

  vendorSha256 = "1nrm105r3zkp3pd1c0n65r97gvjqvv5n553ml3yf857libxlrjd3";
  subPackages = [ "cmd/got" ];

  meta = with stdenv.lib; {
    description = "Simple and fast concurrent downloader";
    homepage = "https://github.com/melbahja/got";
    license = licenses.mit;
  };
}
