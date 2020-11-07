{ pkgs }:

{
  env-ruby = pkgs.buildEnv {
    name = "env-ruby";
    meta.priority = 0;
    paths = with pkgs; [ bundix pry rubyPackages.pry-doc ruby ];
  };
}
