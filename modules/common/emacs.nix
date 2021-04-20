{ config, pkgs, ... }:
let
  inherit (pkgs.lib) mkEnableOption mkIf mkMerge mkOption types;
  cfg = config.profiles.emacs;
in
{
  options = {

    profiles.emacs = {
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
