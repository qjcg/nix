{ stdenv, emacs, fetchFromGitHub }:
let
  inherit (stdenv.lib) fakeSha256;
in
stdenv.mkDerivation {
  pname = "org-z";
  version = "20210105.03";

  src = fetchFromGitHub {
    owner = "landakram";
    repo = "org-z";
    rev = "4583b0617ae0a04e1d6a0a00da125e152f0a2f45";
    sha256 = fakeSha256;
  };

  installPhase = ''
    install -d $out/share/emacs/site-lisp
    install *.el *.elc $out/share/emacs/site-lisp
  '';

  meta = with stdenv.lib; {
    description = "Lightweight, Org-mode flavored zettelkasten links.";
    homepage = "https://github.com/landakram/org-z";
    license = licenses.gpl3;
  };


}
