{
  pkgs ? import <nixpkgs> {},
  ...
}:

with pkgs;
{
  go-4d = callPackage ./4d {};
  horeb = callPackage ./horeb {};
  mtlcam = callPackage ./mtlcam {};
  loccount = callPackage ./loccount {};
}
