{ pkgs }:
let
  inherit (builtins)
    attrNames
    isNull
    match
    readDir
    ;
  inherit (pkgs) callPackage;
  inherit (pkgs.lib) filterAttrs;
  inherit (pkgs.lib.attrsets) genAttrs;
in
{
  # Filter out packages by regex from an attrset.
  # Returns an attrset containing only package names NOT matching regex.
  # When regex is null, do no filtering.
  # E.g.:
  #   > pkgs = { aaa = 1; bbb = 2; ccc = 3; };
  #   > filterPackages { attrs = pkgs; regex = "aaa|bbb"; }
  #   { ccc = 3; }
  filterPackages = { attrs, regex }:
    filterAttrs
      (k: v:
        isNull regex || # No filtering when regex is null.
        isNull (match regex k))
      attrs;

  # pkgsFromDir creates a {pname: derivation} attrset given an input dir.
  # input: A directory path. The directory should contain nix package subdirs.
  # output: An attrset mapping package names to package derivations.
  pkgsFromDir = dir:
    genAttrs
      (attrNames (readDir dir))
      (name: callPackage (dir + "/${name}") { });
}
