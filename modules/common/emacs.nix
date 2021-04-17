{ config, pkgs, ... }:
let
  inherit (pkgs.lib) mkEnableOption mkIf mkMerge mkOption types;
  cfg = config.roles.emacs;
in
{
  options = {

    roles.emacs = {
      enable = mkEnableOption "emacs";
      orgDir = mkOption {
        type = types.path;
        default = false;
        description = "Base directory for org-mode files";
      };
    };

  };

  config = {

    environment.systemPackages = mkIf cfg.enable (with pkgs; [
      jg.envs.env-emacs
      hello
    ]);

  };
}
