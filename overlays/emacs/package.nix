# Inspired by: https://github.com/peel/dotfiles/blob/master/overlays/20-emacs/emacs/default.nix

{
  pkgs,
}:

let
  # From: https://github.com/Jeschli/jeschli-nix/blob/3daaafeca3531e5390812e406886892e4371890f/emacs.nix
  pkgsWithOverlay = import <nixpkgs> {
    overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      }))
    ];
  };
  myConfig = ../../files/init.el;
in
  pkgsWithOverlay.emacsWithPackagesFromUsePackage {
    config = builtins.readFile myConfig;

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


