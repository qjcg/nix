{ pkgs }:

with pkgs;

dockerTools.buildImage {
  name = "emacs";
  tag = "latest";
  created = "now";
  contents = jg.overrides.emacs;

  config = {
    cmd = [ "/bin/emacs" ];
  };
}
