{
  pkgs ? import <nixpkgs> {},
  ...
}:

let self = with pkgs; rec {
  go-4d = callPackage ./4d {};
  loccount = callPackage ./loccount {};
}; in self
