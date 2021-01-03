{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-personal";
  paths = [
    jg.custom.d4
    jg.custom.horeb
    jg.custom.mtlcam
  ] ++ lib.lists.optionals stdenv.isLinux [ jg.custom.barr ];
  meta = {
    priority = 0;
    description = "An environment for using apps I've written";
  };
}
