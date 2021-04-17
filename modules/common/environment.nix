{ config, pkgs, ... }:

{
  config =
    {
      # The following base config is always applied when this role is enabled.
      environment.systemPackages = with pkgs.jg.envs; [
        env-go
        env-k8s
        env-multimedia
        env-nix
        env-personal
        env-python
        env-tools
      ];

      environment.variables = {
        EDITOR = "nvim";
        PAGER = "less";
        VISUAL = "nvim";
      };
    };
}
