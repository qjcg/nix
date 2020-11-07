self: super:

{
  sxiv = super.sxiv.override { conf = builtins.readFile ./sxiv-config.h; };
}
