{
  pkgs ? import <nixpkgs> {},
  ...
}:

with pkgs;
{
  go-4d = callPackage ./4d {};
  mtlcam = callPackage ./mtlcam {};
  loccount = callPackage ./loccount {};
}
