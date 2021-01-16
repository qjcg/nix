{ pkgs }:

with pkgs;

dockerTools.buildImage {
  name = "hello";
  tag = "latest";
  created = "now";
  contents = hello;

  config.cmd = [ "/bin/hello" ];
}
