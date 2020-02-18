{ pkgs, secrets, ... }:

{
  fonts.fontconfig.enable = true;
  manual.html.enable = true;

  # FIXME: Not working (settings.ini is *empty*), so creating manual config file below.
  #gtk = with pkgs; {
  #  enable = true;

  #  font = {
  #    package = roboto;
  #    name = "Roboto 18";
  #  };

  #  theme = {
  #    package = qogir-theme;
  #    name = "Qogir-light";
  #  };

  #};


  home = {
    language = {
      base = "en_US.utf8";
    };

    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
      PAGER = "less";
      VISUAL = "nvim";

      NIX_PATH = "nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs:nixos-config=$HOME/.config/nixpkgs/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";

      QT_PLATFORMTHEME = "qt5ct";
      QT_PLATFORM_PLUGIN = "qt5ct";
      QT_QPA_PLATFORMTHEME = "qt5ct";

      MAILRC = "$HOME/.config/s-nail/mailrc";
    };

    keyboard = {
      layout = "us,ca";
      model = "pc105";
      options = ["grp:shifts_toggle"];
    };

    packages = with pkgs; [
      env-workstation
    ];

  };


  programs = {

    alacritty = {
      enable = true;
      settings = {
        font.family = "monospace";
        font.style = "Regular";
        font.size = 22.0;

        cursor.text = "0x000000";
        cursor.color = "0xffffff";
      };
    };

    bash = {
      enable = true;
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
      '';

      shellAliases = rec {
        k = "kubectl";

        ls = "ls --color --human-readable --group-directories-first";
        grep = "grep -E";
        tree = "tree -A -C";

      # NOTE: Home manager ALWAYS uses <nixpkgs> for the package set.
      # Ref: https://github.com/rycee/home-manager/issues/376#issuecomment-419666167
        hm = "home-manager";
        hms = "${hm} switch -A luban";
        hmRemoveAllBut3 = "${hm} generations | awk 'NR > 3 {print $5}' | xargs home-manager remove-generations && nix-collect-garbage";

        # Aliases for downloading audio via youtube-dl.
        ytj = "youtube-dl --dump-single-json" ;
        yta = "youtube-dl --add-metadata --embed-thumbnail --ignore-errors -o '%(playlist)s/%(playlist_index)02d. %(uploader)s - %(title)s.mp3'";

        drwWinVM = "rdesktop -u ${secrets.work-user} -p - -g 1680x1050 -K mt1n-${secrets.work-user}";
      };
    };

    firefox.enable = true;

    git = {
      enable = true;
      userName = "${secrets.git-name}";
      userEmail = "${secrets.git-email}";
      ignores = [
        "node_modules"
        "__pycache__"
        "*.pyc"
        "*.iso"
        ".netrwhist"
      ];

      aliases = {
        br = "branch -avv";
        ci = "commit";
        co = "checkout";
        de = "daemon --verbose --export-all";
        dl = "diff HEAD^ HEAD";
        ds = "diff --staged";
        lasttag = "describe --tags --abbrev=0";
        lg = "log --pretty=format:'%C(yellow)%h%Creset %s  %C(red)<%cn> %Cgreen[%cr] %Creset%d' --graph";
        lga = "log --pretty=format:'%C(yellow)%h%Creset %s  %C(red)<%cn> %Cgreen[%cr] %Creset%d' --graph --all";
        re = "remote -v";
        reu = "remote set-url";
        st = "status --column";

        # Via https://git.wiki.kernel.org/index.php/Aliases#Use_graphviz_for_display
        graphviz = "!f() { echo 'digraph git {' ; git log --pretty='format:  %h -> { %p }' \"$@\" | sed 's/[0-9a-f][0-9a-f]*/\"&\"/g' ; echo '}'; }; f";

	# find fat git files
	# via: https://stackoverflow.com/questions/9456550/how-to-find-the-n-largest-files-in-a-git-repository#comment59168142_28783843
	fatfiles = "!f() { git ls-tree -r -l --abbrev --full-name HEAD | sort -rnk4 | head -20; }; f";
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
        setw -g window-status-style	     "fg=white dim"
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


  services = {

    #gpg-agent = {
    #  enable = true;
    #  defaultCacheTtl = 3600;
    #  defaultCacheTtlSsh = 3600;
    #  enableScDaemon = false;
    #  enableSshSupport = true;
    #  extraConfig = ''
    #    allow-emacs-pinentry
    #  '';
    #};

    # FIXME: i3lock does NOT unlock with correct password!
    #services.screen-locker = {
    #  enable = true;
    #  lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
    #};
    #polybar = {
    #  enable = true;
    #};

    syncthing.enable = true;

  };

  xdg.configFile = {
    "albert/albert.conf".source = ../files/albert.conf ;
    "cmus/rc".source = ../files/cmusrc ;
    "emacs/init.el".source = ../files/emacs/init.el;
    "fontconfig/conf.d/50-user-font-preferences.conf".source = ../files/50-user-font-preferences.conf;
    "gtk-3.0/settings.ini".source = ../files/gtk-3.0_settings.ini ;
    "i3/workspace1.json".source = ../files/workspace1_luban.json ;
    "nvim/coc-settings-example.json".source = ../files/coc-settings.json ;
    "s-nail/mailrc".text = pkgs.callPackage ../files/mailrc.nix { inherit secrets; };
    "sxiv/exec/key-handler" = {
      executable = true;
      source = ../../files/sxiv-key-handler.sh ;
    };
    "VSCodium/User/settings_example.json".source = ../files/vscodium_settings_example.json ;
    "xonsh/".source = ../../files/xonsh ;
  };

  xdg.dataFile = {
    "fonts/Apl385.ttf" = {
      source = ../files/fonts/Apl385.ttf;
      onChange = "fc-cache -f";
    };
  };

  #xresources.properties = {
  #  "Xft.dpi" = 96;
  #  "Xft.autohint" = 0;
  #  "Xft.lcdfilter" = "lcddefault";
  #  "Xft.hintstyle" = "hintfull";
  #  "Xft.hinting" = 1;
  #  "Xft.antialias" = 1;
  #  "Xft.rgba" = "rgb";
  #};

  xsession = {
    enable = true;

    pointerCursor = with pkgs; {
      name = "Vanilla-DMZ";
      package = vanilla-dmz;
      size = 64;
    };

    initExtra = ''
      xrdb -merge ~/.Xresources
    '';
  };

}
