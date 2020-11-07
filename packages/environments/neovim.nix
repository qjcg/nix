{ pkgs }:

{
  env-neovim = pkgs.buildEnv {
    name = "env-neovim";
    meta.priority = 0;
    paths = with pkgs; [ neovim nodejs ];
  };
}
