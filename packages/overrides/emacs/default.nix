{ pkgs, stdenv }:

let
  inherit (stdenv.lib) fakeSha256;

  # See https://github.com/peel/dotfiles/blob/a75b18f887b5f4ddd987d8988a0bdecab8d92cd7/overlays/20-emacs/emacs/default.nix
  elisp = src: file:
    pkgs.runCommand "${file}.el" {} ''
    mkdir -p $out/share/emacs/site-lisp
    cp -r ${src}/* $out/share/emacs/site-lisp/
    '';
in
# See https://github.com/nix-community/emacs-overlay/#extra-library-functionality
pkgs.emacsWithPackagesFromUsePackage {
  config = ../../../files/emacs/init.org;

  # Set to `false` to ONLY pull in packages with `:ensure`.
  alwaysEnsure = false;

  # Since I have `#+PROPERTY: header-args: emacs-lisp :tangle yes` at the top of init.org.
  alwaysTangle = true;

  # E.g. for packages not in ELPA, MELPA, etc.
  override = epkgs: epkgs // {

    ob-go = elisp (pkgs.fetchFromGitHub {
      owner = "pope";
      repo = "ob-go";
      rev = "2067ed55f4c1d33a43cb3f6948609d240a8915f5";
      sha256 = "sha256-fN3dFDUl9SF6CLJ8ikYmJ3BvRwpuqX/pZiftWH1LPBk=";
    }) "ob-go";

    org-z = elisp (pkgs.fetchFromGitHub {
      owner = "landakram";
      repo = "org-z";
      rev = "4583b0617ae0a04e1d6a0a00da125e152f0a2f45";
      sha256 = "sha256-08zb8iBz5FI8ez70rfZ0eli+FrZDfIfGCI/JXgTPWTA=";
    }) "org-z";

    rigpa = elisp (pkgs.fetchFromGitHub {
      owner = "countvajhula";
      repo = "rigpa";
      rev = "932b83f12afb80f1ab2167c027c84a2b2aa45f17";
      sha256 = "sha256-dpUJgJMOuOPG1vdJXMf7y6ld/gIFSsyxVzqC2hwKb8g=";
    }) "rigpa";

    solo-jazz-theme = elisp (pkgs.fetchFromGitHub {
      owner = "cstby";
      repo = "solo-jazz-emacs-theme";
      rev = "3a2d1a0b404ba7c765526a1b76e0f1148ed8d0f2";
      sha256 = "sha256-Gk4kzKkHKUkzeJ0NfoTbc06l12pPHraxducm8ak32gE=";
    }) "solo-jazz-theme";

  };

  extraEmacsPackages = epkgs: with epkgs; [
    solo-jazz-theme
    ob-go
    org-z
    rigpa
  ];
}
