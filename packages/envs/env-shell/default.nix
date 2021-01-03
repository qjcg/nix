{ pkgs, ... }:

with pkgs;

# NOTE: Installing this environment along with the programs.bash.enable
# option results in a glitchy-looking prompt!
buildEnv {
  name = "env-shell";
  paths = [
    bash
    bash-completion
    xonsh
  ] ++ lib.lists.optionals stdenv.isLinux [ ];
  meta = {
    priority = 0;
    description = "An environment for shell development, completions, and tools";
  };
}
