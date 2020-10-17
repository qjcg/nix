self: super:

{
  env-personal = super.pkgs.buildEnv {
    name = "env-personal";
    meta.priority = 0;
    paths = with super.pkgs;
      [ go-4d horeb mtlcam ] ++ lib.lists.optionals stdenv.isLinux [ barr ];
  };
}
