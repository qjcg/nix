# FIXME: Installs no files!
{ lib
, rustPlatform
, fetchFromGitHub
, cmake
, llvmPackages
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "wasmer";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "wasmerio";
    repo = pname;
    rev = version;
    sha256 = "sha256-9jto/pGtA7gZQKrpvbFh/kJCCXfLr9aV8FjW67LrMtY=";
    fetchSubmodules = true;
  };

  cargoSha256 = "sha256-E+pt34jIqrnkrEJpimpCcRDOxq+HMS0iSdT43/xdd1g=";

  nativeBuildInputs = [ cmake pkg-config ];

  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  meta = with lib; {
    description = "The Universal WebAssembly Runtime";
    longDescription = ''
      Wasmer is a standalone WebAssembly runtime for running WebAssembly outside
      of the browser, supporting WASI and Emscripten. Wasmer can be used
      standalone (via the CLI) and embedded in different languages, running in
      x86 and ARM devices.
    '';
    homepage = "https://wasmer.io/";
    license = licenses.mit;
    maintainers = with maintainers; [ Br1ght0ne ];
  };
}
