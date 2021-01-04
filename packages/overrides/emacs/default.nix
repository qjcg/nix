{ pkgs }:

# See https://github.com/nix-community/emacs-overlay/#extra-library-functionality
pkgs.emacsWithPackagesFromUsePackage {
  config = ../../../files/emacs/init.org;

  # Set to `false` to ONLY pull in packages with `:ensure`.
  alwaysEnsure = false;

  # Since I have `#+PROPERTY: header-args: emacs-lisp :tangle yes` at the top of init.org.
  alwaysTangle = true;
}
