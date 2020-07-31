{ pkgs, ... }:

with pkgs;
{
  environment = {
    systemPackages = [ env-k8s env-neovim env-nix env-personal env-tools ];
    variables = {
      EDITOR = "nvim";
      PAGER = "less";
      VISUAL = "nvim";
    };
  };

  # Use experimental nix flakes.
  # See https://nixos.wiki/wiki/Flakes#Installing_nix_flakes
  nix = {
    package = nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
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
      env-tools
      env-vscodium
    ];
  };
}
