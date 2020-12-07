{ stdenv, fetchFromGitHub, buildGoModule, }:

buildGoModule rec {
  pname = "benthos";
  version = "3.35.0";

  src = fetchFromGitHub {
    owner = "Jeffail";
    repo = "benthos";
    rev = "v${version}";
    sha256 = "sha256-rQ9IF6Wf2E6t6aB35vjtpIu60nXgkunbVcA40pL7gso=";
  };

  vendorSha256 = "sha256-atgn0jIwMD3aKIDbdKNHi4bB5sASqOnyqTLl0P9g2U8=";
  
  buildFlagsArray = [
    "-ldflags="
    "-X github.com/Jeffail/benthos/v3/lib/service.Version=${src.rev}"
    "-X github.com/Jeffail/benthos/v3/lib/service.DateBuilt=TimelessBuild"
  ];

  subPackages = [ "cmd/benthos" ];

  meta = with stdenv.lib; {
    description = "A stream processor for mundane tasks written in Go";
    homepage = "https://github.com/Jeffail/benthos";
    license = licenses.mit;
  };
}
