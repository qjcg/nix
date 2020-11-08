final: prev:

{
  sxiv = prev.sxiv.override { conf = builtins.readFile ./sxiv-config.h; };
}
