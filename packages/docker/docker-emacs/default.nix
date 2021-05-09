{ pkgs }:
let
  inherit (pkgs) dockerTools;
in
dockerTools.buildImage {
  name = "emacs";
  tag = "latest";
  created = "now";
  contents = with pkgs; [
    busybox
    jg.overrides.emacs
  ];

  config = {
    cmd = [ "/bin/emacs" ];
  };
}
