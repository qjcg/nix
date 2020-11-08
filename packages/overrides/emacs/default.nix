final: prev:

{
  # See https://github.com/nix-community/emacs-overlay/#extra-library-functionality
  emacs = prev.emacs.override prev.emacsWithPackagesFromUsePackage {
    config = ../../../files/emacs/init.el;
  };
}
