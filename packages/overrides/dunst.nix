{ pkgs }:

{
  dunst = pkgs.dunst.override { dunstify = true; };
}
