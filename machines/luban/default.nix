{
  pkgs,
  lib,

  pg,
  secrets,
  ...
}:

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

      NIX_PATH = "nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";

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

    packages =
      lib.lists.flatten (lib.attrsets.collect builtins.isList pg.GUI) ++
      lib.lists.flatten (lib.attrsets.collect builtins.isList pg.CLI)
      ;

  };


  programs = {

    alacritty = {
      enable = true;
      settings = {
        font.family = "Iosevka"; # FIXME: alacritty font family not working!
        font.style = "Regular";
        font.size = 6.0;

        cursor.text = "0x000000";
        cursor.color = "0xffffff";
      };
    };

    autorandr.enable = true;

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
        ls = "ls --color=auto";
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

    emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.nix-mode
        epkgs.magit
        epkgs.paradox
      ];
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

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
      configure = {
        customRC = builtins.readFile ../../files/nvimrc;
        packages.myVimPackage = with pkgs.vimPlugins; pg.vim;
      };
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

    compton = {
      enable = true;
      fade = true;
      fadeExclude = [
        "class_g ~= 'dmenu'"
      ];
      activeOpacity = "1.0";
      inactiveOpacity = "1.0";
    };

    dunst = {
      enable = true;

      # Docs: https://github.com/dunst-project/dunst/blob/master/docs/dunst.pod
      settings = {

        global = {
          alignment = "center";
          browser = "${pkgs.firefox}/bin/firefox -new-tab";
          dmenu = "${pkgs.dmenu}/bin/dmenu -fn 'Iosevka:size=35' -nb '#000000' -sb '#a10094' -sf '#ffffff'";
          font = "Iosevka Heavy 18";
          frame_width = "3";
          padding = "10";
        };

        shortcuts = {
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
          history = "ctrl+apostrophe";
          context = "ctrl+shift+apostrophe";
        };

        urgency_normal = {
          background = "#000000";
          foreground = "#a2ffa2";
          frame_color = "#a2ffa2";
          separator_color = "#a2ffa2";
        };

      };
    };

    gpg-agent = {
      enable = true;
      defaultCacheTtl = 3600;
      defaultCacheTtlSsh = 3600;
      enableScDaemon = false;
      enableSshSupport = true;
      extraConfig = ''
        allow-emacs-pinentry
      '';
    };

    # FIXME: i3lock does NOT unlock with correct password!
    #services.screen-locker = {
    #  enable = true;
    #  lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
    #};

    # TODO: Configure and enable polybar as i3 statusbar.
    #polybar = {
    #  enable = true;
    #};

    syncthing.enable = true;
    xscreensaver.enable = true;

  };

  xdg.configFile = {
    "albert/albert.conf".source = ../../files/albert.conf ;
    "cmus/rc".source = ../../files/cmusrc ;
    "gtk-3.0/settings.ini".source = ../../files/gtk-3.0_settings.ini ;
    "i3/workspace1.json".source = ../../files/workspace1_luban.json ;
    "nvim/coc-settings.json".source = ../../files/coc-settings.json ;
    "s-nail/mailrc".text = pkgs.callPackage ../../files/mailrc.nix { inherit secrets; };
  };

  xdg.dataFile = {
    "fonts/Apl385.ttf" = {
      source = ../../files/fonts/Apl385.ttf;
      onChange = "fc-cache -f";
    };
    "nvim/site/after/ftplugin/go.vim".source = ../../files/go.vim ;
  };

  xsession = {
    enable = true;

    pointerCursor = with pkgs; {
      name = "Vanilla-DMZ";
      package = vanilla-dmz;
      size = 64;
    };

    windowManager.i3 = 
    let
      modifier = "Mod4";

      cmd_term = "${pkgs.st}/bin/st -f 'Iosevka-13'";
      cmd_term_tmux = "${cmd_term} -t 'tmux-main' -e sh -c 'tmux new -ADs main'";

      cmd_menu = "${pkgs.dmenu}/bin/dmenu_run -fn 'Iosevka:size=20' -nb '#000000' -sb '#00fcff' -sf '#000000'";
      cmd_browser = "${pkgs.firefox}/bin/firefox";
      cmd_slack = "${pkgs.slack}/bin/slack";

      left = "h";
      down = "j";
      up = "k";
      right = "l";
    in {
      enable = true;

      extraConfig = ''
        default_border  pixel 4
        title_align     center
      '';

      config = {
        fonts = [
          "Iosevka Medium 13"
        ];

        modifier = "${modifier}";

        gaps = {
          inner = 10;
          outer = 10;
        };

        keybindings =
          lib.mkOptionDefault {

            # Start apps
            "${modifier}+Return" = "exec ${cmd_term}";
            "${modifier}+d"      = "exec ${cmd_menu}";

            # Focus windows
            "${modifier}+${left}"  = "focus left";
            "${modifier}+${down}"  = "focus down";
            "${modifier}+${up}"    = "focus up";
            "${modifier}+${right}" = "focus right";

            # Move windows
            "${modifier}+Shift+${left}"  = "move left";
            "${modifier}+Shift+${down}"  = "move down";
            "${modifier}+Shift+${up}"    = "move up";
            "${modifier}+Shift+${right}" = "move right";

            # Switch workspaces
            "${modifier}+n"       = "workspace next_on_output";
            "${modifier}+p"       = "workspace prev_on_output";
            "${modifier}+Tab"     = "workspace back_and_forth";

            # Move containers accross outputs.
            "${modifier}+Shift+period"       = "move container to output right";
            "${modifier}+Shift+comma"        = "move container to output left";

            # Use scratchpad
            "${modifier}+minus"       = "scratchpad show";
            "${modifier}+Shift+minus" = "move scratchpad";

            "${modifier}+Shift+e" = "exit";
            "${modifier}+Shift+x" = "kill";

            # Control pulseaudio volume for default sink.
            # Ref: https://wiki.archlinux.org/index.php/PulseAudio#Keyboard_volume_control
            "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";

            # Control brightness.
            "XF86MonBrightnessDown" = "exec sudo brightness -5";
            "XF86MonBrightnessUp" = "exec sudo brightness +5";
	  };

        # NOTE: Border of i3-gaps windows is set via childBorder.
        colors = {
          focused         = { border = "#0000ff"; background = "#000000"; text = "#00ffed"; indicator = "#ffffff"; childBorder = "#0000ff"; };
          focusedInactive = { border = "#000000"; background = "#000000"; text = "#ffffff"; indicator = "#ffffff"; childBorder = "#000000"; };
          unfocused       = { border = "#000000"; background = "#222222"; text = "#999999"; indicator = "#ffffff"; childBorder = "#000000"; };
        };

        bars = [{
          position = "top";
          mode = "dock";

          fonts = [
            "Iosevka Medium 15"
          ];

          colors = {
            background = "#000000";
            statusline = "#cccccc";
            separator  = "#00ffea";

            focusedWorkspace   = {border = "#000000"; background = "#000000"; text = "#00fcff"; };
            activeWorkspace    = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
            inactiveWorkspace  = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
            urgentWorkspace    = {border = "#00ff00"; background = "#000000"; text = "#ffffff"; };
          };

          statusCommand = "while barr; do sleep 5 ; done";
        }];

        startup = [
          { notification = false; command = "i3-msg 'workspace 1; append_layout ~/.config/i3/workspace1.json'"; }
          { notification = false; command = "~/.fehbg"; }
          { notification = false; command = "${pkgs.albert}/bin/albert"; }

          { notification = false; command = "${cmd_term_tmux}"; }
          { notification = false; command = "${cmd_browser}"; }

          # Set faster key repeat rate, inspired by EXWM.
          # Results in snappier Emacs usage.
          # See https://github.com/ch11ng/exwm/blob/master/xinitrc
          { notification = false; command = "xset r rate 200 60"; }
        ];

      };
    };
  };
}
