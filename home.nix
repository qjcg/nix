# home-manager configuration.
# See https://github.com/rycee/home-manager#usage
# For a good example with i3 configuration, see:
#   https://github.com/j0xaf/dotfiles/blob/master/.config/nixpkgs/home.nix
{ pkgs, lib ? pkgs.stdenv.lib, ... }:

{
  home.packages = (with pkgs; [

    # BROKEN
    # FIXME: These apps close immediately on startup, complaining about GLX.
    alacritty
    zoom-us
    glxinfo
    cool-retro-term

    # Utilities
    ansible
    aria2
    st

    baresip
    openssl

    # MultiMedia
    alsaLib
    alsaPlugins
    alsaPluginWrapper
    alsaTools
    alsaUtils
    cmus
    pulseaudio
    pulseeffects
    mpv

    # Dev Tools
    ctags
    delve
    fossil
    go
    tig
    upx

    davmail
    docker-compose
    fzf
    qemu
    ripgrep
    mkpasswd

    # GUI & Window Manager
    dmenu
    feh
    gcolor3
    gtk2fontsel
    i3blocks-gaps
    i3lock
    sxiv
    zathura
    fontconfig-penultimate
    iosevka
    mesa

    # VideoConferencing
    bluejeans-gui
  ]);

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
  };

  home.language = {
    base = "en_US.utf8";
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.autorandr.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    configure = {
      customRC = ''
        colorscheme abstract

        set autochdir
        set hls
        set nowrap
        set wildmenu

        autocmd FileType yaml setlocal ai et sw=2 ts=2 cuc
        autocmd FileType nix setlocal cuc
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

  home.keyboard = {
    layout = "us,ca";
    model = "pc105";
    options = ["grp:shifts_toggle"];
  };

  manual.html.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
  };

  programs.firefox = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "John Gosset";
    userEmail = "jgosset@drw.com";
  };

  # X11 compositor (transparency, etc).
  services.compton = {
    enable = true;
    activeOpacity = "0.9";
  };

  services.dunst = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 3600;
    defaultCacheTtlSsh = 3600;
    enableScDaemon = false;
    enableSshSupport = true;
    extraConfig = ''
      allow-emacs-pinentry
    '';
  };

  # FIXME: Does NOT unlock with correct password!
  #services.screen-locker = {
  #  enable = true;
  #  lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
  #};

  # Assuming this is needed when NOT using NixOS.
  systemd.user = {
    systemctlPath = "/usr/bin/systemctl";
  };

  xsession = {
    enable = true;

    windowManager.i3 = 
    let
      modifier = "Mod4";
      left = "";
    in {
      enable = true;
      config = {
        modifier = "${modifier}";

        gaps = {
          inner = 8;
          outer = 8;
        };

        keybindings =
          lib.mkOptionDefault {
            "${modifier}+period" = "exec i3lock";
            "${modifier}+Return" = "exec ${pkgs.st}/bin/st -f 'Iosevka Term:style=Regular:size=16'";
	  };

        colors = {
          focused         = { border = "#000000"; background = "#000000"; text = "#00ffed"; indicator = "#ffffff"; childBorder = "#000000"; };
          focusedInactive = { border = "#000000"; background = "#000000"; text = "#ffffff"; indicator = "#ffffff"; childBorder = "#000000"; };
          unfocused       = { border = "#000000"; background = "#222222"; text = "#999999"; indicator = "#ffffff"; childBorder = "#000000"; };
        };

        bars = [{
          command = "${pkgs.i3blocks-gaps}/bin/i3blocks";
          position = "top";

          colors = {
            background = "#000000";
            statusline = "#cccccc";
            separator  = "#00ffea";

            focusedWorkspace   = {border = "#000000"; background = "#000000"; text = "#00fcff"; };
            activeWorkspace    = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
            inactiveWorkspace  = {border = "#000000"; background = "#000000"; text = "#cccccc"; };
            urgentWorkspace    = {border = "#00ff00"; background = "#000000"; text = "#ffffff"; };
          };
        }];

        startup = [
          # FIXME: Remove absolute path for alacritty when working via home-manager.
          { command = "/usr/bin/alacritty"; notification = false; }
          { command = "firefox"; notification = false; }
          { command = "~/.fehbg"; notification = false; }
          { command = "home-manager-help"; notification = false; }
        ];

      };
    };
  };
}
