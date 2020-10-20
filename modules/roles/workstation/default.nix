{ pkgs, ... }:

with pkgs;
let cfg = config.roles.workstation;
in {

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

  config = { };

  imports = [ ./fonts.nix ./gnome.nix ./sway.nix ];

  environment = {
    systemPackages = [ env-k8s env-neovim env-nix env-personal env-tools ];
    variables = {
      EDITOR = "nvim";
      PAGER = "less";
      VISUAL = "nvim";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.tmux.enable = true;
  programs.tmux.extraConfig = builtins.readFile ../../../files/tmux.conf;

  # LINUX-SPECIFIC CONFIG.
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

  # DARWIN-SPECIFIC CONFIG.
} // lib.attrsets.optionalAttrs stdenv.isDarwin {

  environment = {

    # Use a custom configuration.nix location.
    # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/configuration.nix
    darwinConfig = "$HOME/.config/nixpkgs/configuration.nix";

    systemPackages = [
      env-go
      env-k8s
      env-multimedia
      env-neovim
      env-nix
      env-personal
      env-python
      env-tools
      env-vscodium
    ];
  };

}
