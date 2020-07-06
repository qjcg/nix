self: super:

{
  env-vscodium = super.pkgs.buildEnv {
    name = "env-vscodium";
    meta.priority = 0;
    paths = with super.pkgs; [ vscodium-with-extensions ];
  };
}
