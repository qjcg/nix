{ pkgs }:
let
  emacs-nox = pkgs.jg.overrides.emacs.overrideAttrs(old: {
    package = pkgs.emacs-nox;
  });
in
emacs-nox
