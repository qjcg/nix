{ config, pkgs, ... }:

with pkgs;
let
  cfg = config.roles.workstation;
in
{
  imports =
    [ ./fonts.nix ]
    ++ lib.lists.optionals cfg.gnome [ ./gnome.nix ]
    ++ lib.lists.optionals cfg.sway [ ./sway.nix ];

  options = {

    # The workstation role uses the Facade Pattern to expose a small number of
    # options that summarize the desired values for a larger number of options.
    #
    # See https://en.wikipedia.org/wiki/Facade_pattern
    roles.workstation = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable the workstation role.";
      };

      games = mkOption {
        type = types.bool;
        default = false;
        description = "Install games.";
      };

      gnome = mkOption {
        type = types.bool;
        default = false;
        description =
          "Install the GNOME desktop environment and related packages.";
      };

      sway = mkOption {
        type = types.bool;
        default = false;
        description = "Install Sway and related packages.";
      };

    };
  };

  config = {
    environment.systemPackages = [
      env-go
      env-k8s
      env-multimedia
      env-nix
      env-personal
      env-python
      env-tools
    ];

    environment.variables.EDITOR = "nvim";
    environment.variables.PAGER = "less";
    environment.variables.VISUAL = "nvim";

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnsupportedSystem = true;

    programs.bash.enable = true;
    programs.bash.enableCompletion = true;
    programs.gnupg.agent.enable = true;
    programs.gnupg.agent.enableSSHSupport = true;
    programs.tmux.enable = true;
    programs.tmux.extraConfig = builtins.readFile ../../../files/tmux.conf;

  } // lib.attrsets.optionalAttrs stdenv.isLinux {

    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ ];
    networking.firewall.allowedUDPPorts = [ ];

    programs.mtr.enable = true;

    security.sudo.wheelNeedsPassword = false;

    services.gpm.enable = true;
    services.printing.enable = true;
    services.openssh.enable = true;
    services.resolved.dnssec = "false";

    virtualisation.docker.enable = true;
    #virtualisation.virtualbox.host.enable = true;

  };
}
