# home-manager configuration.
#
# Uses the home-manager nix-darwin module, which provides the
# home-manager.users.<user> options below.
# Ref: https://rycee.gitlab.io/home-manager/index.html#sec-install-nix-darwin-module

{ pkgs, ... }:

{
  # Users should be defined in secrets.nix.
  home-manager.users.jgosset = {
    home.packages = import ./home_packages.nix { inherit pkgs; } ;

    programs = {
      alacritty.enable = true;
      alacritty.settings = {
        background_opacity = 0.85;
        colors.cursor.cursor = "0xe502d2";
        font.normal.family = "Iosevka";
        font.size = 14;
        shell.program = "/run/current-system/sw/bin/xonsh";
        window.dimensions = {
          columns = 160;
          lines = 40;
        };
      };
    };

    xdg.configFile = {
      "cmus/rc".source = ../../files/cmusrc ;
      "emacs/init.el".source = ../../files/emacs/init.el;
      "nvim/coc-settings-example.json".source = ../../files/coc-settings.json ;
      "xonsh/".source = ../../files/xonsh ;
    };

  };
}
