{ pkgs }:

# See https://github.com/nix-community/emacs-overlay/#extra-library-functionality
pkgs.emacsWithPackagesFromUsePackage {
  config = ../../../files/emacs/init.org;
  alwaysTangle = true;
}
