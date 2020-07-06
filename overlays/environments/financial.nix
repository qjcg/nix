self: super:

{
  env-financial = super.pkgs.buildEnv {
    name = "env-financial";
    meta.priority = 0;
    paths = with super.pkgs; [ beancount fava ];
  };
}
