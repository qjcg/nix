{ pkgs }:
let
  inherit (builtins) match;
  inherit (pkgs.lib) filterAttrs;
in
{
  # Filter out packages by regex from an attrset.
  # Returns an attrset containing only package names NOT matching regex.
  # E.g.:
  #   > pkgs = { aaa = 1; bbb = 2; ccc = 3; };
  #   > filterPackages { attrs = pkgs; regex = "aaa|bbb"; }
  #   { ccc = 3; }
  filterPackages = { attrs, regex }:
    filterAttrs
      (k: v: (regex == "") || (match regex k) == null)
      attrs;
}
