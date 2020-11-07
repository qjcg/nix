self: super:
let
  customPackageNames = builtins.attrNames (builtins.readDir ../packages/custom);
in
super.lib.attrsets.genAttrs customPackageNames (name:
  super.callPackage (../packages/custom + "/${name}") { }
);
