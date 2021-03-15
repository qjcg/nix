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

  config = mkMerge [

    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        jg.overrides.emacs

        # Optional dependencies for various emacs packages.
        graphviz # Used by org-roam
        tectonic # Used by org-export LaTeX
        zathura # A PDF reader for reading emacs-generated PDFs.
      ];
    })

  ];
}
