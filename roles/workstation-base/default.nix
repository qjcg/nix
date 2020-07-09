{ pkgs, ... }:

with pkgs;
{
  environment = {
    systemPackages =
      [ env-k8s env-neovim env-nix env-personal env-shell env-tools ];

    shellAliases = {
      codium =
        "codium --enable-proposed-api ms-vscode-remote.remote-containers";
      ls = "ls --color --group-directories-first";
      k = "kubectl";
    };

    variables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    tmux = {
      enable = true;
      extraConfig = builtins.readFile ../../files/tmux.conf;
    };
  };

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
      env-shell
      env-tools
      env-vscodium
    ];
  };
}
