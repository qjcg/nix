# home-manager configuration.
# See https://github.com/rycee/home-manager

{
  pkgs,
  lib ? pkgs.stdenv.lib,
  ...
}:

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

      # TODO: For *applications*, create packages using buildGoModule.
      # Ref: https://nixos.org/nixpkgs/manual/#ssec-go-modules
      packages = {
        "github.com/qjcg/4d" = builtins.fetchGit "git@github.com:qjcg/4d";
      };
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
      configure = {
        customRC = ''
          colorscheme abstract

          set autochdir
          set autoindent
          set hlsearch			" highlight search results
          set ignorecase			" case insensitive searches
          set laststatus=1		" only show statusbar if >1 windows open
          set listchars=tab:>-,eol:$
          set nowrap
          set shortmess+=I		" disable welcome screen
          set smartcase			" case-sensitive search only if specified
          set splitright			" vsplit window to the right by default
          set wildmenu			" dmenu-style menu
          set wildmode=full

          "" MAPS
          "" See :h keycodes
          let mapleader=","

          nnoremap <leader>l :set list!<CR>
          nnoremap <leader>r :source $MYVIMRC<CR>
          nnoremap <leader>S :setlocal spell!<CR>
          nnoremap <leader>v :e $MYVIMRC<CR>
          nnoremap <leader>w :w !sudo tee %<CR><CR>

          nnoremap <leader>g :Goyo<CR>

          autocmd FileType yaml setlocal ai et sw=2 ts=2 cuc
          autocmd FileType nix setlocal cuc
          autocmd FileType go,python nested :TagbarOpen
        '';

        packages.myVimPackage = with pkgs.vimPlugins; {
          start = [
            ansible-vim
            awesome-vim-colorschemes
            fzf-vim
            goyo
            limelight-vim
            neosnippet
            nerdtree
            python-mode
            tagbar
            vim-nix
          ];
        };

      };
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
    "i3/status.toml" = {
      onChange = "i3-msg restart";
      text = ''
        # i3status-rust configuration

        theme = "slick"
        icons = "awesome"

        [[block]]
        block = "weather"
        format = "{temp}°/{weather}"
        service = { name = "openweathermap", api_key = "${secrets.openweathermap-api-key}", city_id = "${secrets.openweathermap-city-id}", units = "metric" }

        # DISABLED: Information overload.
        #[[block]]
        #block = "nvidia_gpu"
        #label = "Quadro P1000"

        # DISABLED: Information overload.
        #[[block]]
        #block = "xrandr"
        #resolution = true

        # DISABLED: Information overload.
        #[[block]]
        #block = "uptime"

        [[block]]
        block = "disk_space"
        path = "/"
        alias = "/"
        info_type = "available"
        unit = "GB"
        interval = 20
        warning = 20.0
        alert = 10.0

        [[block]]
        block = "load"
        interval = 1
        format = "{1m} {5m} {15m}"

        [[block]]
        block = "sound"

        [[block]]
        block = "time"
        interval = 60
        format = "%a %b %-d, %-I:%M%P"
      '';
    };
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
            "${modifier}+Return" = "exec ${cmd_term}";
            "${modifier}+d"      = "exec ${cmd_menu}";

            "${modifier}+${left}"  = "focus left";
            "${modifier}+${down}"  = "focus down";
            "${modifier}+${up}"    = "focus up";
            "${modifier}+${right}" = "focus right";

            "${modifier}+Shift+${left}"  = "move left";
            "${modifier}+Shift+${down}"  = "move down";
            "${modifier}+Shift+${up}"    = "move up";
            "${modifier}+Shift+${right}" = "move right";

            "${modifier}+n"       = "workspace next_on_output";
            "${modifier}+p"       = "workspace prev_on_output";
            "${modifier}+Tab"     = "workspace back_and_forth";

            "${modifier}+minus"       = "scratchpad show";
            "${modifier}+Shift+minus" = "move scratchpad";
	  };

        # FIXME: i3 border is NOT being set for full windows, just title tabs.
        colors = {
          focused         = { border = "#0000ff"; background = "#000000"; text = "#00ffed"; indicator = "#ffffff"; childBorder = "#000000"; };
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

          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3/status.toml";
        }];

        startup = [
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
