{ config, pkgs, ... }:

{
  config = {
    programs.bash.enableCompletion = true;
    programs.gnupg.agent.enable = true;
    programs.gnupg.agent.enableSSHSupport = true;
    programs.tmux.enable = true;
    programs.tmux.extraConfig = builtins.readFile ../../files/tmux.conf;
  };
}
