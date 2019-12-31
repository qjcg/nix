self: super:

{
  emacs = super.callPackage ./package.nix {} ;
  emacs-nox = super.callPackage ./package_nox.nix {} ;
}
