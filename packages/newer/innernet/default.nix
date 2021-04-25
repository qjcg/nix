{ pkgs }:

let
  inherit (pkgs) fetchFromGitHub libiconv linuxHeaders llvmPackages sqlite;
  inherit (pkgs.darwin) Security;
  inherit (pkgs.lib) fakeSha256 licenses maintainers optionals;
  inherit (pkgs.rustPlatform) buildRustPackage;
  inherit (pkgs.stdenv) isDarwin;

  pname = "innernet";
  version = "1.2.0";
in
buildRustPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "tonarino";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Z4F5RYPVgFiiDBg6lxILjAh/a/rL7IJBqHIJ/tQyLnE=";
  };

  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  nativeBuildInputs = with llvmPackages; [ llvm clang ];
  buildInputs = [ libiconv sqlite ] ++ optionals isDarwin [ Security ];
  cargoSha256 = "sha256-WSkN5aXMgfqZJAV1b3elF7kwf2f5OpcntKSf8620YcY=";

  meta = {
    description = "A private network system that uses WireGuard under the hood";
    homepage = "https://github.com/tonarino/innernet";
    license = licenses.mit;
    maintainers = with maintainers; [ tomberek _0x4A6F ];
  };
}
