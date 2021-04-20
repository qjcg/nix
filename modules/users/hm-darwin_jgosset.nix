# home-manager configuration.
#
# Uses the home-manager nix-darwin module, which provides the
# home-manager.users.<user> options below.
# Ref: https://rycee.gitlab.io/home-manager/index.html#sec-install-nix-darwin-module
let
  secrets = import ../../secrets.nix;
in
{ pkgs, ... }:

{
  inherit (secrets) users;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.jgosset = {
    programs = {

      alacritty = {
        enable = true;
        settings = {
          # Interesting font families:
          #   - "Andale Mono" (macOS)
          #   - "Inconsolata Nerd Font Mono" (nixpkgs)
          font.normal.family = "JuliaMono";
          font.normal.style = "Regular";
          font.size = 20.0;

          # Avoid having to manually switch from zsh -> bash.
          # Manually specified here instead of /etc/passwd because this user's shell is centrally managed.
          shell = {
            program = "/bin/bash";
            args = [ "--login" ];
          };

          colors = {
            cursor = {
              text = "#000000";
              cursor = "#ef02f7";
            };

            # # Color Theme: Challenger Deep
            # # Ref: https://github.com/eendroroy/alacritty-theme

            # # Default colors
            # primary = {
            #   background = "0x1b182c";
            #   foreground = "0xcbe3e7";
            # };

            # # Normal colors
            # normal = {
            #   black = "0x100e23";
            #   red = "0xff8080";
            #   green = "0x95ffa4";
            #   yellow = "0xffe9aa";
            #   blue = "0x91ddff";
            #   magenta = "0xc991e1";
            #   cyan = "0xaaffe4";
            #   white = "0xcbe3e7";
            # };

            # # Bright colors
            # bright = {
            #   black = "0x565575";
            #   red = "0xff5458";
            #   green = "0x62d196";
            #   yellow = "0xffb378";
            #   blue = "0x65b2ff";
            #   magenta = "0x906cff";
            #   cyan = "0x63f2f1";
            #   white = "0xa6b3cc";
            # };

            # Color Theme: Hyper
            # Ref: https://github.com/eendroroy/alacritty-theme

            # Default colors
            primary = {
              background = "0x000000";
              foreground = "0xffffff";
            };

            # Normal colors
            normal = {
              black = "0x000000";
              red = "0xfe0100";
              green = "0x33ff00";
              yellow = "0xfeff00";
              blue = "0x0066ff";
              magenta = "0xcc00ff";
              cyan = "0x00ffff";
              white = "0xd0d0d0";
            };

            # Bright colors
            bright = {
              black = "0x808080";
              red = "0xfe0100";
              green = "0x33ff00";
              yellow = "0xfeff00";
              blue = "0x0066ff";
              magenta = "0xcc00ff";
              cyan = "0x00ffff";
              white = "0xFFFFFF";
            };
          };
        };
      };

      bash = {
        enable = true;
        profileExtra = ''
          # user's nix profile executables.
          export PATH=~/.nix-profile/bin:$PATH

          # nodejs
          export npm_config_prefix=~/.node_modules
          export PATH=$npm_config_prefix/bin:$PATH

          # go
          export GOPATH=~/go
          export GOBIN=$GOPATH/bin
          export PATH=$GOBIN:$PATH
        '' +

        # fzf functions
        # See https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
        ''

            fzf_find_edit() {
              local file=$(
                fzf --query="$1" --no-multi --select-1 --exit-0 \
                    --preview 'bat --color=always --line-range :500 {}'
                )
              if [[ -n $file ]]; then
                  $EDITOR "$file"
              fi
            }

            alias ffe='fzf_find_edit'

            fzf_change_directory() {
              local directory=$(
                fd --type d | \
                fzf --query="$1" --no-multi --select-1 --exit-0 \
                    --preview 'tree -C {} | head -100'
                )
              if [[ -n $directory ]]; then
                  cd "$directory"
              fi
            }

            alias fcd='fzf_change_directory'
          '';

        initExtra = ''
          command -v direnv >/dev/null && eval "$(direnv hook bash)"
          command -v starship >/dev/null && eval "$(starship init bash)"
          command -v zoxide >/dev/null && eval "$(zoxide init bash)"
        '';

        sessionVariables = rec {
          BROWSER = "firefox";
          EDITOR = "nvim";
          LC_COLLATE = "C";
          PAGER = "less";
          PS1 = "\\u@\\h \\W \\$ ";

          # See https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
          FZF_DEFAULT_COMMAND = "fd --type f --color=never";
          FZF_CTRL_T_COMMAND = "${FZF_DEFAULT_COMMAND}";
          FZF_CTRL_T_OPTS =
            "--preview 'bat --color=always --line-range :500 {}'";
          FZF_ALT_C_COMMAND = "fd --type d . --color=never";
          FZF_ALT_C_OPTS = "--preview 'tree -C {} | head -100'";
          FZF_DEFAULT_OPTS =
            " --height 75% --multi --reverse --bind ctrl-f:page-down,ctrl-b:page-up ";
        };

        shellAliases = rec {
          # Print all Active Directory groups. It seems they have GID >= 10000.
          drwADGroups =
            "id | sed -e 's/,/\\n/g' -e 's/(/: /g' -e 's/)//g' | sort -n | awk -F: '/^[1-9]/ && $1 > 10000'";
          drwHomeUsage =
            "shopt -s dotglob && du --threshold 1M --exclude={G,H,W,X} -s ~/* | sort -n | sed 's/.home.jgosset.//' | awk '{print $2,$1}' | goplot bar";


          # EMACS
          e = "emacs";
          em = "emacs -s /tmp/emacs503/server"; # emacs macos
          ec = "emacsclient"; # emacs client
          ecm = "emacsclient -s /tmp/emacs503/server"; # emacs client macos
          ect = "emacsclient -t"; # emacs client terminal
          ecmt = "emacsclient -ts /tmp/emacs503/server"; # emacs client macos terminal

          grep = "grep -E";
          k = "kubectl";
          ls = "${pkgs.coreutils}/bin/ls --color --group-directories-first";
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

        delta = {
          enable = true;
          options = { features = "side-by-side line-numbers decorations"; };
        };

        extraConfig = { pull.rebase = false; };

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
      "cmus/rc".source = ../../files/cmusrc;
      "emacs/init.org".source = ../../files/emacs/init.org;
      "nix/nix.conf".text = ''
        experimental-features = nix-command flakes # See https://www.tweag.io/blog/2020-05-25-flakes/
      '';
      "nvim/coc-settings.json".source = ../../files/coc-settings.json;
      "starship.toml".source = ../../files/starship.toml;
      "tig/config".source = ../../files/tigrc;
      "xonsh/".source = ../../files/xonsh;
    };
  };
}
