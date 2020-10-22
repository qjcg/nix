{ config, pkgs, ... }:

with pkgs;
let
  fonts = [
    fira-code
    go-font
    inconsolata-nerdfont
    iosevka
    julia-mono
    noto-fonts
    roboto
    unifont
    victor-mono
  ] ++ lib.lists.optionals stdenv.isLinux [ noto-fonts-emoji noto-fonts-extra ];
in {
  environment = {
    systemPackages = [ env-k8s env-neovim env-nix env-personal env-tools ];
    variables = {
      EDITOR = "nvim";
      PAGER = "less";
      VISUAL = "nvim";
    };
  };

  nix.extraOptions = "experimental-features = nix-command flakes";
  nix.package = pkgs.nixUnstable;

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

  fonts = {
    fonts = fonts;
    enableDefaultFonts = true;
    fontDir.enable = true;

    fontconfig.enable = true;
    fontconfig.defaultFonts = {
      emoji = [ "Noto Color Emoji" "Noto Emoji" "Unifont" ];
      monospace = [ "JuliaMono" "Iosevka" "Victor Mono" "Go Mono" "Unifont" ];
      sansSerif = [ "Noto Sans" "Roboto Medium" "Unifont" ];
      serif = [ "Noto Serif" "Roboto Slab" "Unifont" ];
    };
  };

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
    #darwinConfig = "$HOME/.config/nixpkgs/configuration.nix";

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

  # nix-darwin font configuration.
  # See https://github.com/LnL7/nix-darwin/blob/master/modules/fonts/default.nix
  fonts = {
    enableFontDir = true;
    fonts = fonts;
  };

}
