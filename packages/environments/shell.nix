final: prev:

with prev;
{
  # NOTE: Installing this environment along with the programs.bash.enable
  # option results in a glitchy-looking prompt!
  env-shell = buildEnv {
    name = "env-shell";
    meta.priority = 0;
    paths = [
      bash
      bash-completion
      xonsh
    ] ++ lib.lists.optionals stdenv.isLinux [ ];
  };
}
