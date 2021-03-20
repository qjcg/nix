{ config, lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
  inherit (lib) mkEnableOption mkIf mkMerge;

  cfg = config.roles.workstation;
in
{
  imports = [
    ./desktop.nix
    ./fonts.nix
    ./games.nix
    ./gnome.nix
    ./sway.nix
  ];

  options = {

    # The workstation role uses the Facade Pattern to expose a small number of
    # options that summarize the desired values for a larger number of options.
    #
    # See https://en.wikipedia.org/wiki/Facade_pattern
    roles.workstation = {
      enable = mkEnableOption "workstation role";
      desktop = mkEnableOption "desktop packages";
      games = mkEnableOption "games";
      gnome = mkEnableOption "GNOME desktop environment and related packages";
      sway = mkEnableOption "sway and related packages";
    };
  };

  config = mkMerge [

    # The following base config is always applied when this role is enabled.
    {
      environment.systemPackages = with pkgs.jg.envs; [
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

      nix.extraOptions = "experimental-features = nix-command flakes";
      nix.package = pkgs.nixUnstable;
      nix.trustedUsers = [ "root" "@wheel" ];

      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnsupportedSystem = true;

      programs.bash.enableCompletion = true;
      programs.gnupg.agent.enable = true;
      programs.gnupg.agent.enableSSHSupport = true;
      programs.tmux.enable = true;
      programs.tmux.extraConfig = builtins.readFile ../../../files/tmux.conf;
    }

    (mkIf isLinux {

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

    })

  ];
}
