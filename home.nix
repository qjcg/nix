# home-manager configuration.
# See https://github.com/rycee/home-manager

# TODO: Use separate configurations for different environments (ex: home, work).

{ pkgs, lib, ... }:

let
  pg = pkgs.callPackage ./pkgGroups.nix {};

  # A secrets.nix file should be created containing the following values.
  secrets = if builtins.pathExists ./secrets.nix then import ./secrets.nix else {
    openweathermap-api-key = "";
    openweathermap-city-id = "";
    work-user = "";
    git-name = "";
    git-email = "";
  };
in
{
  fonts.fontconfig.enable = true;
  manual.html.enable = true;

  gtk = {
    enable = true;
  };


  home = {
    language = {
      base = "en_US.utf8";
    };

    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
      PAGER = "less";
      VISUAL = "nvim";
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

      shellAliases = {
        ls = "ls --color=auto";
        grep = "grep -E";
        tree = "tree -A -C";

        hm = "home-manager";
        hms = "home-manager switch";
        hmRemoveAllBut3 = "home-manager generations | awk 'NR > 3 {print $5}' | xargs home-manager remove-generations && nix-collect-garbage";

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
        "*.pyc"
        "*.iso"
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

    go = {
      enable = true;
      goPath = "go";
      goBin = "go/bin";
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
      configure = {
        customRC = lib.strings.fileContents ./files/nvimrc;

        packages.myVimPackage = with pkgs.vimPlugins; {
          start = [
            ansible-vim
            awesome-vim-colorschemes
            fzf-vim
            goyo
            limelight-vim
            neosnippet
            neosnippet-snippets
            nerdtree
            python-mode
            tagbar
            vim-go
            vim-nix
            vim-toml
          ];
        };

      };
    };

    tmux = {
      enable = true;
      escapeTime = 10;
      shortcut = "b";
      terminal = "screen-256color";
    };

  };


  services = {

    # FIXME: compton fails, complaining about GLX.
    compton = {
      enable = false;
      activeOpacity = "0.9";
    };

    dunst = {
      enable = true;
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

    # TODO: polybar -- configure and use, or remove
    polybar = {
      enable = false;
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
    "cmus/rc".source = ./files/cmusrc;
    "i3/workspace1.json".source = ./files/workspace1.json;

    "i3/i3status-rust.toml" = {
      source = ./files/i3status-rust.toml;
      onChange = "i3-msg restart";
    };
  };

  xdg.dataFile = {
    "nvim/site/after/ftplugin/go.vim".source = ./files/go.vim;
  };

  xsession = {
    enable = true;

    windowManager.i3 = 
    let
      modifier = "Mod4";

      cmd_term = "${pkgs.st}/bin/st -f 'monospace:style=regular:size=11'";
      # FIXME: nix dmenu_run not working on Ubuntu 18.04
      cmd_menu = "dmenu_run -fn 'monospace:style=Regular:size=13' -nb '#000000'";
      cmd_browser = "${pkgs.firefox}/bin/firefox";
      cmd_slack = "${pkgs.slack}/bin/slack";

      left = "h";
      down = "j";
      up = "k";
      right = "l";
    in {
      enable = true;

      extraConfig = ''
        default_border pixel 5

        # Disable floating slack window to enable layout restore.
        for_window [class="^Slack$"] floating disable
      '';

      config = {
        fonts = [
          "monospace 11"
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

            # Use scratchpad
            "${modifier}+minus"       = "scratchpad show";
            "${modifier}+Shift+minus" = "move scratchpad";

            "${modifier}+Shift+e" = "exit";
	  };

        # NOTE: Border of i3-gaps windows is set via childBorder.
        colors = {
          focused         = { border = "#0000ff"; background = "#000000"; text = "#00ffed"; indicator = "#ffffff"; childBorder = "#00ff83"; };
          focusedInactive = { border = "#000000"; background = "#000000"; text = "#ffffff"; indicator = "#ffffff"; childBorder = "#000000"; };
          unfocused       = { border = "#000000"; background = "#222222"; text = "#999999"; indicator = "#ffffff"; childBorder = "#000000"; };
        };

        bars = [{
          position = "top";
          mode = "dock";

          fonts = [
            "monospace 11"
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

          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3/i3status-rust.toml";
        }];

        startup = [
          { notification = false; command = "i3-msg 'workspace 1; append_layout ~/.config/i3/workspace1.json'"; }
          { notification = false; command = "~/.fehbg"; }

          { notification = false; command = "${cmd_slack}"; }
          { notification = false; command = "${cmd_term}"; }
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
