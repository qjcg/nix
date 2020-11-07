{ pkgs }:

{
  # NOTE: Installing this environment along with the programs.bash.enable
  # option results in a glitchy-looking prompt!
  env-shell = pkgs.buildEnv {
    name = "env-shell";
    meta.priority = 0;
    paths = with pkgs;
      [ bash bash-completion xonsh ] ++ lib.lists.optionals stdenv.isLinux [ ];
  };
}
