{ pkgs, ... }:

{
  environment = {

    # Use a custom configuration.nix location.
    # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/configuration.nix
    darwinConfig = "$HOME/.config/nixpkgs/configuration.nix";

    shellAliases = {
      codium =
        "codium --enable-proposed-api ms-vscode-remote.remote-containers";
      ls = "ls --color --group-directories-first";
      k = "kubectl";
    };

    shells = with pkgs; [ bash xonsh ];

    systemPackages = with pkgs; [
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

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  time.timeZone = "America/Montreal";

}
