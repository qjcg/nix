final: prev:

with prev;
{
  env-personal = buildEnv {
    name = "env-personal";
    meta.priority = 0;
    paths = [
      d4
      horeb
      mtlcam
    ] ++ lib.lists.optionals stdenv.isLinux [ barr ];
  };
}
