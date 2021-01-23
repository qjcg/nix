{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-desktop";
  paths = [
    firefox
  ];
  meta = {
    priority = 0;
    description = "An environment for desktop apps";
  };
}
