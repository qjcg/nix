{ pkgs, ... }:

{
  environment = {

    # Use a custom configuration.nix location.
    # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/configuration.nix
    darwinConfig = "$HOME/.config/nixpkgs/configuration.nix";

    shellAliases = {
      ls = "ls --color --group-directories-first";
      k = "kubectl";
    };

    shells = with pkgs; [
      bashInteractive_5
      xonsh
    ];

    systemPackages = with pkgs; [
      bashInteractive_5
      getent
      neovim
      xonsh
    ];

    variables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };
  };
}
