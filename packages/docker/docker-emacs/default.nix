{ pkgs }:
let
  inherit (pkgs) dockerTools;
  inherit (pkgs.jg.overrides) emacs;
in
dockerTools.buildImage {
  name = "emacs";
  tag = "latest";
  created = "now";
  contents = emacs;

  config = {
    cmd = [ "/bin/emacs" ];
  };
}
