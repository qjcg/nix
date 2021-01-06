{ pkgs, ... }:

{
  programs = {

    autorandr.enable = true;

    bash = {
      enable = true;

      initExtra = ''

        # Run xonsh shell by default, overriding LDAP settings.
        # DISABLED, since it prevents login from GDM after reboot.
        #exec ${pkgs.xonsh}/bin/xonsh
      '';

      profileExtra = ''
        export LC_COLLATE=C
        export PAGER=less

        # nodejs
        export npm_config_prefix=~/.node_modules
        export PATH=$npm_config_prefix/bin:$PATH

        # go
        export GOPATH=~/go
        export GOBIN=$GOPATH/bin
        export PATH=$GOBIN:$PATH

        # nix
        if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

        # Run xonsh shell by default, overriding LDAP settings.
        # DISABLED, since it prevents login from GDM after reboot.
        #exec ${pkgs.xonsh}/bin/xonsh
      '';

      shellAliases = rec {
        k = "kubectl";

        ls = "ls --color --human-readable --group-directories-first";
        grep = "grep -E";
        tree = "tree -A -C";

        # NOTE: Home manager ALWAYS uses <nixpkgs> for the package set.
        # Ref: https://github.com/rycee/home-manager/issues/376#issuecomment-419666167
        hm = "home-manager";
        hms = "${hm} switch -A eiffel";
        hmRemoveAllBut3 =
          "${hm} generations | awk 'NR > 3 {print $5}' | xargs home-manager remove-generations && nix-collect-garbage";

        # Print all Active Directory groups. It seems they have GID >= 10000.
        drwADGroups =
          "id | sed -e 's/,/\\n/g' -e 's/(/: /g' -e 's/)//g' | sort -n | awk -F: '/^[1-9]/ && $1 > 10000'";
        drwHomeUsage =
          "shopt -s dotglob && du --threshold 1M --exclude={G,H,W,X} -s ~/* | sort -n | sed 's/.home.jgosset.//' | awk '{print $2,$1}' | goplot bar";
        drwWinVM =
          "rdesktop -u ${secrets.work-user} -p - -g 1680x1050 -K mt1n-${secrets.work-user}";
      };
    };

    firefox.enable = true;

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

    go = rec {
      enable = true;
      goPath = "go";
      goBin = "${goPath}/bin";
    };

    tmux = {
      enable = true;
      escapeTime = 10;
      shortcut = "b";
      terminal = "screen-256color";
      historyLimit = 10000;
      extraConfig = ''
        set -g renumber-windows on
        set -g set-titles on
        set -g set-titles-string "tmux: #H/#S/#W"

        set -sa terminal-overrides ',st-256color:RGB'

        set -g status-left "[#H/#S] "
        set -g status-left-length 25
        set -g status-right ""
        set -g status-right-length 25
        set -g status-justify left
        set -g message-style                 "fg=green bright"
        set -g status-style                  "fg=white dim"
        setw -g window-status-style       "fg=white dim"
        setw -g window-status-current-style  "fg=cyan  dim"

        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"

        bind C command-prompt -p "New session name:" "new-session -s %1"
        bind R source-file ~/.tmux.conf \; display-message "source-file ~/.tmux.conf"
        bind < command-prompt -p "Rename session to:" "rename-session %%"
        bind > choose-tree "move-window -t %%"

        bind -r M-Left previous-window
        bind -r M-Right next-window

        #bind -r C-Left previous-session
        #bind -r C-Right next-session
      '';
    };

  };
}
