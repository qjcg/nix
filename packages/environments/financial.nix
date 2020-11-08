final: prev:

with prev;
{
  env-financial = buildEnv {
    name = "env-financial";
    meta.priority = 0;
    paths = [ beancount fava ];
  };
}
