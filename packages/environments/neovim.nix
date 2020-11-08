final: prev:

with prev;
{
  env-neovim = buildEnv {
    name = "env-neovim";
    meta.priority = 0;
    paths = [ neovim nodejs ];
  };
}
