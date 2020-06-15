{
  stdenv,
  buildGoPackage,
  fetchFromGitHub
}:

buildGoPackage rec {
  pname = "kompose";
  version = "1.20.0";

  goPackagePath = "github.com/kubernetes/kompose";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "kubernetes";
    repo = "kompose";
    sha256 = "1zgxm3zcxapav4jxh1r597rmxmlxcgns1l8w632ch7d90x5ihvll";
  };

  meta = with stdenv.lib; {
    description = "A tool to help users who are familiar with docker-compose move to Kubernetes";
    homepage = "https://github.com/kubernetes/kompose";
    license = licenses.asl20;
    maintainers = with maintainers; [ thpham vdemeester ];
    platforms = platforms.unix;
  };
}
