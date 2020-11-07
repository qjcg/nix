# Inspired by: https://github.com/peel/dotfiles/blob/master/overlays/20-emacs/emacs/default.nix

{ pkgs, }:

pkgs.emacsWithPackagesFromUsePackage {
  config = builtins.readFile ../../../files/emacs/init.el;
  package = pkgs.emacs-nox;

  # TODO: Figure out how to deploy my personal init.el via this overlay (i.e. avoiding home-manager).
  #override = epkgs: epkgs // {
  #  myConfig = (pkgs.runCommand "init.el" {} ''
  #           mkdir -p $out/share/emacs/site-lisp
  #           cp -r ${myConfig} $out/share/emacs/site-lisp/init.el
  #  '');
  #};
  #extraEmacsPackages = epkgs: with epkgs; [
  #] ++ [
  #  myConfig
  #];
}
