{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "kubeseal";
  version = "0.12.4";

  src = fetchFromGitHub {
    owner = "bitnami-labs";
    repo = "sealed-secrets";
    rev = "v${version}";
    sha256 = "1abm63fb40zky5i97wm6h8ifmdf6i71ws9y7217hv2rnja37f4zd";
  };

  deleteVendor = true;
  vendorSha256 = "1sd453mbaxr575i7dpimxkxzdhy29jdlac0hg9a39yq27mrjzpqm";

  buildFlagsArray = [ "-ldflags=-s -w -X main.VERSION=${version}" ];

  subPackages = [ "cmd/kubeseal" ];

  meta = with stdenv.lib; {
    description =
      "A Kubernetes controller and tool for one-way encrypted Secrets";
    homepage = "https://github.com/bitnami-labs/sealed-secrets";
    license = licenses.asl20;
    maintainers = with maintainers; [ groodt ];
  };
}
