{
  pkgs ? import <nixpkgs> {},
  ...
}:

with pkgs;
{
  go-4d = callPackage ./4d {};
  loccount = callPackage ./loccount {};
}
