{ pkgs, ...  }:

with pkgs;
{
  go-4d = callPackage ./4d {};
  brightness = callPackage ./brightness {};
  horeb = callPackage ./horeb {};
  mtlcam = callPackage ./mtlcam {};

  loccount = callPackage ./loccount {};  # FIXME: loccount doesn't compile.
}
