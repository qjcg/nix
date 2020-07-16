self: super:

{
  # NOTE: Installing this environment along with the programs.bash.enable
  # option results in a glitchy-looking prompt!
  env-shell = super.pkgs.buildEnv {
    name = "env-shell";
    meta.priority = 0;
    paths = with super.pkgs;
      [ bash bash-completion xonsh ] ++ lib.optional stdenv.isLinux [ ];
  };
}
