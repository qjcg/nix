{
  allowUnfree = true;

  # TODO: Replace packageOverrides with overlay?
  # For this, see https://ebzzry.io/en/nix/
  # See:
  #   - https://nixos.org/nixpkgs/manual/#sec-declarative-package-management
  #   - https://github.com/CMCDragonkai/.dotfiles-nixos/tree/master#nix-installation
  packageOverrides = pkgs: with pkgs; {

    # Ref: https://nixos.wiki/wiki/Vim#Custom_setup_without_using_Home_Manager
    myNeovim = neovim.override {
      viAlias = true;
      vimAlias = true;
      configure = {
        customRC = builtins.readFile ./files/nvimrc ;
	packages.myVimPackage = with pkgs.vimPlugins; {
	  start = [
            ansible-vim
            awesome-vim-colorschemes
            changeColorScheme-vim
            fzf-vim
            goyo
            limelight-vim

            deoplete-nvim
            deoplete-go
            deoplete-lsp
            neosnippet
            neosnippet-snippets

            nerdtree
            python-mode
            tagbar
            vim-beancount
            vim-go
            vim-jsx-pretty
            vim-nix
            vim-toml
            typescript-vim
	  ];
	  opt = [ ];
	};
      };
    };

    env-cli = {

      personal = pkgs.buildEnv {
        name = "env-personal";
        paths = [
          go-4d
          barr
          horeb
          mtlcam

          battery
          goplot
          k3d
          loccount
          s-nail

          # Clone not working ("No user exists for uid").
          # Known issue, see: https://github.com/NixOS/nixpkgs/issues/31762
          #brightness

        ];
      };

      nix = pkgs.buildEnv {
        name = "env-nix";
        paths = [
          #cachix
          nixops
          nix-bash-completions
          nix-zsh-completions
        ];
      };

      shell = pkgs.buildEnv {
        name = "env-shell";
        paths = [
          bash_5
          bash-completion
        ];
      };

      utilities = pkgs.buildEnv {
        name = "env-utilities";
        paths = [
          aerc
          ansible
          aria2
          binutils
          davmail
          ed
          fdupes
          file
          fortune
          fzf
          gnupg
          gopass
          htop
          iotop
          jq
          lastpass-cli
          libfaketime
          lsof
          mkpasswd
          pandoc
          pdfcpu
          pv
          renameutils
          ripgrep
          tesseract
          tree
          unzip
          utillinux
          weechat

          fava
          python37Packages.beancount

        ];
      };

      network = pkgs.buildEnv {
        name = "env-network";
        paths = [
          bettercap
          caddy
          dnsutils
          iw
          mtr
          nmap
          wireguard-tools
        ];
      };

      backup = pkgs.buildEnv {
        name = "env-backup";
        paths = [
          adb-sync
          rclone
          restic
          rsync
          syncthing
        ];
      };

      multimedia = pkgs.buildEnv {
        name = "env-multimedia";
        paths = [
          alsaLib
          alsaPluginWrapper
          alsaPlugins
          alsaTools
          alsaUtils

          cmus

          ffmpeg
          fluidsynth
          soundfont-fluid

          mpv
          pulseaudio
          sox
          streamripper
          youtube-dl
          youtube-viewer
        ];
      };

      devtools = pkgs.buildEnv {
        name = "env-devtools";
        paths = [
          fossil
          hugo

          # Go.
          delve
          fly
          gnumake
          gocode
          gogetdoc
          gomodifytags
          gotags
          gotools
          errcheck
          upx

          mkcert
          mr

          # Node.
          nodejs
          now-cli

          postgresql_11

          # Python.
          python37Packages.cookiecutter
          python37Packages.ipython
          python37Packages.poetry

          sbcl
          tig
          universal-ctags
        ];
      };

      # NOTE: VirtualBox is enabled at the system level.
      virt = pkgs.buildEnv {
        name = "env-devtools";
        paths = [
          buildah
          dive
          docker-compose
          kubectl
          packer
          podman
          qemu
          skopeo
          tinyemu

          # FIXME: 2019-08-21 - TEMPORARILY disabled since build fails (xen related error).
          #vagrant

          vault
      ];
    };
  };
};
}

  # TODO: Add appropriate formatting to make usable environments as above with env-cli.
  #env-gui = {
  #  browsers = pkgs.buildEnv {
  #    name = "env-gui-browsers";
  #    paths = [
  #      browserpass
  #      chromium
  #      qutebrowser
  #      tor-browser-bundle-bin
  #    ];
  #  };

  #  utilities = [
  #    gcolor3
  #    libnotify
  #    mesa
  #    sent
  #    wireshark
  #    xaos
  #    xorg.xev
  #    xscreensaver
  #    xwinwrap
  #  ];

  #  games = [
  #    nethack
  #    retroarch
  #  ];

  #  dev = [
  #    dbeaver
  #  ];

  #    # NOTE: Screen locker is configured via system config.
  #    window_manager = [
  #      albert
  #      dmenu
  #      i3lock
  #      st
  #    ];

  #    office = [
  #      bluejeans-gui
  #      evince
  #      libreoffice-fresh
  #      rdesktop
  #      slack
  #      thunderbird-bin
  #      zathura
  #    ];

  #    fonts = [
  #      fira-code
  #      font-awesome-ttf
  #      fontconfig-penultimate
  #      go-font
  #      gtk2fontsel
  #      inconsolata
  #      iosevka
  #      libertine
  #      roboto
  #      unifont
  #      unifont_upper
  #    ];

  #    themes = [
  #      arc-icon-theme
  #      lxappearance
  #      qt5ct
  #      qogir-theme
  #      vanilla-dmz
  #    ];

  #    multimedia = [
  #      blender
  #      feh
  #      flashplayer-standalone
  #      gimp # gimp-with-plugins didn't compile! 2019-07-07
  #      imagemagick
  #      inkscape

  #      obs-studio
  #      qt5.qtbase

  #      pavucontrol
  #      picard
  #      pulseeffects
  #      sxiv
  #      vlc
  #    ];

  #    # FIXME: These apps close immediately on startup, complaining about GLX.
  #    broken = [
  #      baresip
  #      cool-retro-term
  #      glxinfo
  #      zoom-us
  #    ];

  #  };

  #  vim = with pkgs.vimPlugins; {
  #    start = [
  #      ansible-vim
  #      awesome-vim-colorschemes
  #      changeColorScheme-vim
  #      fzf-vim
  #      goyo
  #      limelight-vim

  #      deoplete-nvim
  #      deoplete-go
  #      deoplete-lsp
  #      neosnippet
  #      neosnippet-snippets

  #      nerdtree
  #      python-mode
  #      tagbar
  #      vim-beancount
  #      vim-go
  #      vim-jsx-pretty
  #      vim-nix
  #      vim-toml
  #      typescript-vim
  #    ];
  #    opt = [];
  #  };
  #};

#}
