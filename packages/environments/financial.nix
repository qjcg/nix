{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-financial";
  paths = [ beancount fava ];
  meta = {
    priority = 0;
    description = "An environment for personal financial work";
  };
}
