{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-neovim";
  paths = [ neovim nodejs ];
  meta = {
    priority = 0;
    description = "An environment for working with neovim";
  };
}
