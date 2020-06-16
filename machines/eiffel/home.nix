{ pkgs, lib,

secrets, ... }:

{
  fonts.fontconfig.enable = true;
  manual.html.enable = true;

  gtk = { enable = true; };

  home = {
    language = { base = "en_US.utf8"; };

    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
      PAGER = "less";
      VISUAL = "nvim";

      NIX_PATH = "nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs";

      QT_PLATFORMTHEME = "qt5ct";
      QT_PLATFORM_PLUGIN = "qt5ct";
      QT_QPA_PLATFORMTHEME = "qt5ct";

      MAILRC = "$HOME/.config/s-nail/mailrc";
    };

    keyboard = {
      layout = "us,ca";
      model = "pc105";
      options = [ "grp:shifts_toggle" ];
    };

    packages = with pkgs; [ env-workstation ];

  };

  programs = {

    autorandr.enable = true;

    bash = {
      enable = true;

      profileExtra = ''
        export LC_COLLATE=C
        export PAGER=less

        # go
        export GOPATH=~/go
        export GOBIN=$GOPATH/bin
        export PATH=$GOBIN:$PATH

        # nodejs
        export npm_config_prefix=~/.node_modules
        export PATH=$npm_config_prefix/bin:$PATH

        # nix
        if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi

        # Python
        export PYTHONPATH=~/.nix-profile/lib/python3.8/site-packages:$PYTHONPATH
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

        codium =
          "codium --enable-proposed-api ms-vscode-remote.remote-containers --enable-proposed-api ms-vscode-remote.remote-ssh --enable-proposed-api ms-vscode-remote.remote-ssh-edit";

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

    dunst = {
      enable = true;

      # Docs: https://github.com/dunst-project/dunst/blob/master/docs/dunst.pod
      settings = {

        global = {
          monitor = "1";
          alignment = "center";
          geometry = "600x600+25+50";
          browser = "${pkgs.firefox}/bin/firefox -new-tab";
          dmenu =
            "${pkgs.dmenu}/bin/dmenu -fn 'Victor Mono:size=14' -nb '#000000' -sb '#a10094' -sf '#ffffff'";
          font = "Victor Mono Medium 15";
          frame_width = "2";
          padding = "20";
          corner_radius = "10";

          # Docs: https://developer.gnome.org/pango/stable/pango-Markup.html
          markup = "full";
          format = "<span foreground='#38dbff'><b><i>%a</i></b></span>  %s %b";
        };

        shortcuts = {
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
          history = "ctrl+apostrophe";
          context = "ctrl+shift+apostrophe";
        };

        urgency_low = {
          background = "#000000";
          foreground = "#999999";
          frame_color = "#76ff3a";
          separator_color = "#a2ffa2";
        };

        urgency_normal = {
          background = "#000000";
          foreground = "#ffffff";
          frame_color = "#76ff3a";
          separator_color = "#a2ffa2";
        };

        urgency_critical = {
          background = "#000000";
          foreground = "#ff3838";
          frame_color = "#76ff3a";
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
        pinentry-program /usr/bin/pinentry-gnome3
      '';
    };

    # FIXME: i3lock does NOT unlock with correct password!
    #services.screen-locker = {
    #  enable = true;
    #  lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
    #};

    # TODO: Determine whether systemctlPath is needed for anything (Ubuntu 18.04).
    #systemd.user = {
    #  systemctlPath = "/usr/bin/systemctl";
    #};

  };

  xdg.configFile = {
    "cmus/rc".source = ../../files/cmusrc;
    "emacs/init.el".source = ../../files/emacs/init.el;
    "fontconfig/conf.d/50-user-font-preferences.conf".source =
      ../../files/50-user-font-preferences.conf;
    "i3/workspace1.json".source = ../../files/workspace1.json;

    "i3/i3status-rust.toml" = {

      # Using pkgs.callPackage allows antiquotations to be expanded.
      text = pkgs.callPackage ../../files/i3status-rust_eiffel.toml.nix {
        inherit secrets;
      };
      onChange = "i3-msg restart";
    };
    "i3/i3status-rust_smallscreen.toml" = {

      # Using pkgs.callPackage allows antiquotations to be expanded.
      text =
        pkgs.callPackage ../../files/i3status-rust_eiffel-smallscreen.toml.nix {
          inherit secrets;
        };
      onChange = "i3-msg restart";
    };

    "nvim/coc-settings-example.json".source = ../../files/coc-settings.json;
    "s-nail/mailrc".text =
      pkgs.callPackage ../../files/mailrc.nix { inherit secrets; };
    "sxiv/exec/key-handler" = {
      executable = true;
      source = ../../files/sxiv-key-handler.sh;
    };
    "wtf/config.yml".source = ../../files/wtf-config.yml;
    "VSCodium/User/settings_example.json".source =
      ../../files/vscodium_settings_example.json;
    "xonsh/".source = ../../files/xonsh;
  };

  xdg.dataFile = {
    "fonts/Apl385.ttf" = {
      source = ../../files/fonts/Apl385.ttf;
      onChange = "fc-cache -f";
    };
  };

  xresources.properties = {
    "Sxiv.background" = "black";
    "Sxiv.foreground" = "blue";
  };

  #xsession = {
  #  enable = true;

  #  pointerCursor = with pkgs; {
  #    name = "Vanilla-DMZ";
  #    package = vanilla-dmz;
  #    size = 64;
  #  };

  #  windowManager.i3 =
  #  let
  #    modifier = "Mod4";

  #    cmd_term = "st -f 'monospace-11'";
  #    cmd_term_tmux = "${cmd_term} -t 'tmux-main' -e sh -c 'tmux new -ADs main'";

  #    cmd_menu = "${pkgs.dmenu}/bin/dmenu_run -fn 'Iosevka:size=20' -nb '#000000' -sb '#00fcff' -sf '#000000'";
  #    cmd_browser = "${pkgs.firefox}/bin/firefox";
  #    cmd_slack = "${pkgs.slack}/bin/slack";

  #    wpdir = "/home/jgosset/Sync/Pictures/Wallpapers" ;
  #    cmd_browse_wallpaper = "sxiv -artos f ${wpdir}";
  #    # Looks like we first set primary, then move right and wrap around.
  #    cmd_set_wallpaper = "${pkgs.feh}/bin/feh --bg-fill ${wpdir}/gtgraphics.de/infinitus.jpg ${wpdir}/wallpaperfx.com/white-tiger-in-jungle-2560x1440-wallpaper-2916.jpg --geometry -550";

  #    left = "h";
  #    down = "j";
  #    up = "k";
  #    right = "l";
  #  in {
  #    enable = true;

  #    extraConfig = ''
  #      default_border  pixel 8
  #      title_align     center
  #    '';

  #    config = {
  #      fonts = [
  #        "Iosevka Medium 13"
  #      ];

  #      modifier = "${modifier}";

  #      gaps = {
  #        inner = 50;
  #        outer = 10;
  #      };

  #      keybindings =
  #        lib.mkOptionDefault {

  #          # Start apps
  #          "${modifier}+Return" = "exec ${cmd_term}";
  #          "${modifier}+d"      = "exec ${cmd_menu}";
  #          "${modifier}+Shift+b" = "exec ${cmd_browse_wallpaper}";

  #          # Focus windows
  #          "${modifier}+${left}"  = "focus left";
  #          "${modifier}+${down}"  = "focus down";
  #          "${modifier}+${up}"    = "focus up";
  #          "${modifier}+${right}" = "focus right";

  #          # Move windows
  #          "${modifier}+Shift+${left}"  = "move left";
  #          "${modifier}+Shift+${down}"  = "move down";
  #          "${modifier}+Shift+${up}"    = "move up";
  #          "${modifier}+Shift+${right}" = "move right";

  #          # Switch workspaces
  #          "${modifier}+n"       = "workspace next_on_output";
  #          "${modifier}+p"       = "workspace prev_on_output";
  #          "${modifier}+Tab"     = "workspace back_and_forth";

  #          # Move containers accross outputs.
  #          "${modifier}+Shift+period"       = "move container to output right";
  #          "${modifier}+Shift+comma"        = "move container to output left";

  #          # Use scratchpad
  #          "${modifier}+minus"       = "scratchpad show";
  #          "${modifier}+Shift+minus" = "move scratchpad";

  #          "${modifier}+Shift+e" = "exit";
  #          "${modifier}+Shift+x" = "kill";

  #          # Control cmus(1) music playback.
  #          "XF86AudioPlay" = "exec cmus-remote --pause";
  #          "XF86AudioPrev" = "exec cmus-remote --prev";
  #          "XF86AudioNext" = "exec cmus-remote --next";
  #          "XF86AudioStop" = "exec cmus-remote --stop";

  #          # Control pulseaudio volume for default sink.
  #          # Ref: https://wiki.archlinux.org/index.php/PulseAudio#Keyboard_volume_control
  #          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
  #          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
  #          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
  #        };

  #      # NOTE: Border of i3-gaps windows is set via childBorder.
  #      colors = {
  #        focused         = { border = "#0000ff"; background = "#000000"; text = "#00ffed"; indicator = "#ffffff"; childBorder = "#0000ff"; };
  #        focusedInactive = { border = "#000000"; background = "#000000"; text = "#ffffff"; indicator = "#ffffff"; childBorder = "#000000"; };
  #        unfocused       = { border = "#000000"; background = "#222222"; text = "#999999"; indicator = "#ffffff"; childBorder = "#000000"; };
  #      };

  #      bars = [
  #        {
  #          position = "top";
  #          mode = "dock";

  #          fonts = [
  #            "Iosevka Medium 13"
  #          ];

  #          colors = {
  #            background = "#000000";
  #            statusline = "#cccccc";
  #            separator  = "#00ffea";

  #            focusedWorkspace   = {border = "#000000"; background = "#000000"; text = "#00fcff"; };
  #            activeWorkspace    = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
  #            inactiveWorkspace  = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
  #            urgentWorkspace    = {border = "#00ff00"; background = "#000000"; text = "#ffffff"; };
  #          };

  #          statusCommand = "while barr; do sleep 5; done";
  #          extraConfig = ''
  #            output DP-6
  #          '';
  #        }

  #        {
  #          position = "top";
  #          mode = "dock";

  #          fonts = [
  #            "Iosevka Medium 10"
  #          ];

  #          colors = {
  #            background = "#000000";
  #            statusline = "#cccccc";
  #            separator  = "#00ffea";

  #            focusedWorkspace   = {border = "#000000"; background = "#000000"; text = "#00fcff"; };
  #            activeWorkspace    = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
  #            inactiveWorkspace  = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
  #            urgentWorkspace    = {border = "#00ff00"; background = "#000000"; text = "#ffffff"; };
  #          };

  #          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3/i3status-rust_smallscreen.toml";
  #          extraConfig = ''
  #            output DP-4
  #          '';
  #        }

  #        {
  #          position = "top";
  #          mode = "dock";

  #          fonts = [
  #            "Iosevka Medium 10"
  #          ];

  #          colors = {
  #            background = "#000000";
  #            statusline = "#cccccc";
  #            separator  = "#00ffea";

  #            focusedWorkspace   = {border = "#000000"; background = "#000000"; text = "#00fcff"; };
  #            activeWorkspace    = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
  #            inactiveWorkspace  = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
  #            urgentWorkspace    = {border = "#00ff00"; background = "#000000"; text = "#ffffff"; };
  #          };

  #          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3/i3status-rust_smallscreen.toml";
  #          extraConfig = ''
  #            output DP-0
  #          '';
  #        }
  #      ];

  #      startup = [
  #        # FIXME: Redo for new 3-monitor setup.
  #        { notification = false; command = "${pkgs.autorandr}/bin/autorandr -l eiffel"; }
  #        #{ notification = false; command = "i3-msg 'workspace 2; append_layout ~/.config/i3/workspace1.json'"; }
  #        { notification = false; command = "${cmd_set_wallpaper}"; }

  #        { notification = false; command = "${cmd_term_tmux}"; }
  #        { notification = false; command = "${cmd_browser}"; }
  #        { notification = false; command = "${cmd_slack}"; }

  #        # Set faster key repeat rate, inspired by EXWM.
  #        # Results in snappier Emacs usage.
  #        # See https://github.com/ch11ng/exwm/blob/master/xinitrc
  #        { notification = false; command = "xset r rate 200 60"; }
  #      ];

  #    };
  #  };
  #};
}
