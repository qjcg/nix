{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-personal";
  paths = [
    d4
    horeb
    mtlcam
  ] ++ lib.lists.optionals stdenv.isLinux [ barr ];
  meta = {
    priority = 0;
    description = "An environment for using apps I've written";
  };
}
