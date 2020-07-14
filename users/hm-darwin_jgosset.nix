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

      alacritty = {
        enable = true;
        settings = {
          font.normal.family = "Fira Code";
          font.normal.style = "Retina";
          font.size = 16.0;

          colors.cursor.text = "#000000";
          colors.cursor.cursor = "#ef02f7";
          draw_bold_text_with_bright_colors = true;
        };
      };

      bash = {
        enable = true;
        profileExtra = ''
          # nodejs
          export npm_config_prefix=~/.node_modules
          export PATH=$npm_config_prefix/bin:$PATH

          # go
          export GOPATH=~/go
          export GOBIN=$GOPATH/bin
          export PATH=$GOBIN:$PATH

          # nix
          #if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
        '';

        initExtra = ''
          command -v direnv >/dev/null && eval "$(direnv hook bash)"
        '';

        sessionVariables = rec {
          BROWSER = "firefox";
          EDITOR = "nvim";
          LC_COLLATE = "C";
          PAGER = "less";
          PS1 = "\\u@\\h \\W \\$ ";

          FZF_DEFAULT_COMMAND = "fd --type f --color=never";
          FZF_CTRL_T_COMMAND = "${FZF_DEFAULT_COMMAND}";
          FZF_ALT_C_COMMAND = "fd --type d . --color=never";
          FZF_DEFAULT_OPTS =
            " --height 75% --multi --reverse --bind ctrl-f:page-down,ctrl-b:page-up ";
        };

        shellAliases = rec {
          # Print all Active Directory groups. It seems they have GID >= 10000.
          drwADGroups =
            "id | sed -e 's/,/\\n/g' -e 's/(/: /g' -e 's/)//g' | sort -n | awk -F: '/^[1-9]/ && $1 > 10000'";
          drwHomeUsage =
            "shopt -s dotglob && du --threshold 1M --exclude={G,H,W,X} -s ~/* | sort -n | sed 's/.home.jgosset.//' | awk '{print $2,$1}' | goplot bar";
          grep = "grep -E";
          k = "kubectl";
          ls =
            "${pkgs.coreutils}/bin/ls --color --human-readable --group-directories-first";
          tree = "tree -A -C";
          vi = "nvim";
          vim = "nvim";
        };
      };

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
