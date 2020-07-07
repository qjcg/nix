# home-manager configuration.
#
# Uses the home-manager nix-darwin module, which provides the
# home-manager.users.<user> options below.
# Ref: https://rycee.gitlab.io/home-manager/index.html#sec-install-nix-darwin-module

{ pkgs, secrets, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  home-manager.users.jgosset = {
    programs = {
      git = {
        enable = true;
        userName = "${secrets.git-name}";
        userEmail = "${secrets.git-email}";
        ignores = [ "node_modules" "__pycache__" "*.pyc" "*.iso" ".netrwhist" ];

        aliases = {
          br = "branch -avv";
          ci = "commit";
          co = "checkout";
          de = "daemon --verbose --export-all";
          dl = "diff HEAD^ HEAD";
          ds = "diff --staged";
          lasttag = "describe --tags --abbrev=0";
          lg =
            "log --pretty=format:'%C(yellow)%h%Creset %s  %C(red)<%cn> %Cgreen[%cr] %Creset%d' --graph";
          lga =
            "log --pretty=format:'%C(yellow)%h%Creset %s  %C(red)<%cn> %Cgreen[%cr] %Creset%d' --graph --all";
          re = "remote -v";
          reu = "remote set-url";
          st = "status --column";

          # Via https://git.wiki.kernel.org/index.php/Aliases#Use_graphviz_for_display
          graphviz = ''
            !f() { echo 'digraph git {' ; git log --pretty='format:  %h -> { %p }' "$@" | sed 's/[0-9a-f][0-9a-f]*/"&"/g' ; echo '}'; }; f'';

          # find fat git files
          # via: https://stackoverflow.com/questions/9456550/how-to-find-the-n-largest-files-in-a-git-repository#comment59168142_28783843
          fatfiles =
            "!f() { git ls-tree -r -l --abbrev --full-name HEAD | sort -rnk4 | head -20; }; f";
        };
      };
    };

    xdg.configFile = {
      "cmus/rc".source = ../files/cmusrc;
      "emacs/init.el".source = ../files/emacs/init.el;
      "nvim/coc-settings-example.json".source = ../files/coc-settings.json;
      "xonsh/".source = ../files/xonsh;
    };
  };
}
