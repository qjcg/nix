{ config, lib, pkgs, ... }:
let
  cfg = config.roles.emacs;
in
with lib;

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