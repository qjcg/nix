{ pkgs }:
let
  inherit (pkgs) fetchurl makeWrapper;
  inherit (pkgs.lib) fakeSha256 licenses;
  inherit (pkgs.stdenv) mkDerivation;

  version = "0.9";
in
mkDerivation {
  inherit version;
  pname = "eldev";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/doublep/eldev/${version}/bin/eldev";
    sha256 = "sha256-lr7Y0edBMHUQZI3hZ2s8WZXKrv5TFUkb5jqWxAkzVjM=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    install -D -v -m555 "$src" "$out/bin/eldev"
    wrapProgram "$out/bin/eldev" --set ELDEV_EMACS "${pkgs.emacs}/bin/emacs"
  '';

  meta = {
    description = "Elisp development tool";
    homepage = "https://github.com/doublep/eldev";
    license = licenses.gpl3;
  };
}
