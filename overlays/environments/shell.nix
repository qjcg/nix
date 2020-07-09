self: super:

{
  env-shell = super.pkgs.buildEnv {
    name = "env-shell";
    meta.priority = 0;
    paths = with super.pkgs;
      [ bash bash-completion xonsh ] ++ lib.optional stdenv.isLinux [ ];
  };
}
