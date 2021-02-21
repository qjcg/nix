{ pkgs }:
let
  inherit (pkgs) dockerTools hello;
in
dockerTools.buildImage {
  name = "hello";
  tag = "latest";
  created = "now";
  contents = hello;

  config.cmd = [ "/bin/hello" ];
}
