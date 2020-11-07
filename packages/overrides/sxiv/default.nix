{ pkgs }:

{
  sxiv = pkgs.sxiv.override { conf = builtins.readFile ./sxiv-config.h; };
}
