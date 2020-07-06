self: super:

{
  env-neovim = super.pkgs.buildEnv {
    name = "env-neovim";
    meta.priority = 0;
    paths = with super.pkgs; [ neovim nodejs ];
  };
}
