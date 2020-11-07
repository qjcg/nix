{ pkgs }:

{
  env-financial = pkgs.buildEnv {
    name = "env-financial";
    meta.priority = 0;
    paths = with pkgs; [ beancount fava ];
  };
}
