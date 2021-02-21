{ pkgs }:
let
  inherit (builtins) isNull match;
  inherit (pkgs.lib) filterAttrs;
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
}
