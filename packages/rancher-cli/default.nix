{ 
  stdenv,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "rancher-cli";
  version = "2.4.3";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "cli";
    rev = "v${version}";
    sha256 = "0m2d2b2ddmg1q4whg5nvgss05q5dyv1xkqbm1xpgc4939hrz8kff";
  };

  subPackages = [ "." ];
  deleteVendor = true;
  postFixup = ''
    mv "$out"/bin/cli "$out"/bin/rancher
  '';

  meta = with stdenv.lib; {
    description = "The Rancher Command Line Interface (CLI) is a unified tool for interacting with your Rancher Server.";
    homepage = "https://github.com/rancher/cli";
    license = licenses.asl20;
  };
}
