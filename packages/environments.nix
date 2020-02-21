self: super:

let

  # Nixpkgs for last known working xonsh build.
  # See https://hydra.nixos.org/job/nixos/trunk-combined/nixpkgs.xonsh.x86_64-linux
  nixpkgs_xonsh =
    (import (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs_xonsh";
      url = https://github.com/nixos/nixpkgs/;
      rev = "1736affb91d60ca49952c68821d8f6f06078f4f5";
    }) {});

  # Nixpkgs for staging-next version of poetry.
  # See https://hydra.nixos.org/job/nixpkgs/staging-next/poetry.x86_64-linux
  nixpkgs_poetry =
    (import (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs_poetry";
      url = https://github.com/nixos/nixpkgs/;
      rev = "76a439239eb310d9ad76d998b34d5d3bc0e37acb";
    }) {});

  # Nixpkgs for black.
  # See https://hydra.nixos.org/job/nixpkgs/python3/nixpkgs.python38Packages.black.x86_64-linux
  nixpkgs_black =
    (import (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs_black";
      url = https://github.com/nixos/nixpkgs/;
      rev = "b53e237ef679ee8f4dd366750ef01f5ac83de80a";
    }) {});

  # Nixpkgs for cookiecutter.
  # See https://hydra.nixos.org/job/nixos/trunk-combined/nixpkgs.cookiecutter.x86_64-linux
  nixpkgs_cookiecutter =
    (import (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs_cookiecutter";
      url = https://github.com/nixos/nixpkgs/;
      rev = "31bcf8d363b26db0061099e4df314d6769b77b8f";
    }) {});

  # Nixpkgs for bookworm.
  # See https://hydra.nixos.org/job/nixpkgs/trunk/bookworm.x86_64-linux
  nixpkgs_bookworm =
    (import (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs_bookworm";
      url = https://github.com/nixos/nixpkgs/;
      rev = "c636a45e67568398ae4795b7b084ec65878da3a4";
    }) {});


  pkgGroups = with super.pkgs; {

    CLI = {

      personal = [
        go-4d
        barr
        horeb
        mtlcam

        battery
        goplot
        hey
        k3c
        k3d
        loccount
        s-nail

        # Clone not working ("No user exists for uid").
        # Known issue, see: https://github.com/NixOS/nixpkgs/issues/31762
        #brightness
      ];

      nix = [
        cachix
        nix-index
        nixops
        nixpkgs-fmt
        nix-bash-completions
      ];

      shell = [
        bash_5
        bash-completion
        nixpkgs_xonsh.xonsh
      ];

      utilities = [
        ansible
        aria2
        binutils
        davmail
        ed
        elinks
        fdupes
        figlet
        file
        fortune
        fzf
        gnupg
        pinentry
        gopass
        htop
        influxdb
        iotop
        jq
        lastpass-cli
        libfaketime
        lsof
        mkpasswd
        neofetch
        neovim
        pandoc
        pdfcpu
        pup
        pv
        renameutils
        ripgrep
        rlwrap
        sqlite
        telegraf
        tesseract
        toilet
        tree
        unzip
        utillinux
        weechat
        wtf
      ];

      financial = [
        beancount
        fava
      ];

      network = [
        bettercap
        caddy
        dnsutils
        iw
        mtr
        nmap
        wireguard-tools
      ];

      backup = [
        adb-sync
        rclone
        restic
        rsync
        syncthing
      ];

      multimedia = [
        alsaLib
        alsaPluginWrapper
        alsaPlugins
        alsaTools
        alsaUtils

        beets
        cmus

        ffmpeg
        fluidsynth
        soundfont-fluid

        mpv
        opusTools
        pulseaudio
        sox
        strawberry
        streamripper

        python38Packages.mps-youtube
        youtube-dl
        youtube-viewer
      ];

      devtools = [
        cue
        fly
        fossil
        gnumake
        hugo
        vault-bin

        # Go
        delve
        errcheck
        gocode
        gogetdoc
        gomodifytags
        gotags
        gotools
        protobuf
        upx

        mkcert
        mr

        # Node
        nodejs
        now-cli

        postgresql_12

        # Python
        pypy3

        (python38.withPackages (ps: with ps; [
          beautifulsoup4
          ipython
          isort
          mypy
          pylint
          python-dotenv
          requests
        ]))

        nixpkgs_cookiecutter.cookiecutter
        nixpkgs_black.python37Packages.black
        nixpkgs_poetry.poetry


        # Lisp / Scheme
        guile
        janet
        racket
        sbcl

        tig
        universal-ctags
      ];

      # NOTE: VirtualBox is enabled at the system level on NixOS.
      virt = [
        buildah
        conmon
        dive
        docker-compose
        glooctl
        k3d
        kind
        kompose
        kubectl
        kubectx
        kubernetes-helm
        kubeseal
        minikube
        packer
        podman
        qemu
        skaffold
        skopeo
        stern
        tinyemu
        vagrant
      ];

    };

    GUI = {

      browsers = [
        browserpass
        chromium
        firefox-wayland
        qutebrowser
        surf
        tor-browser-bundle-bin
      ];

      utilities = [
        gcolor3
        libnotify
        mesa
        qrencode
        sent
        wireshark
        xaos
        xorg.xclock
        xorg.xdpyinfo
        xorg.xev
        xorg.xeyes
        xorg.xhost
        xorg.xinit
        xorg.xkill
        xscreensaver
        xwinwrap
      ];

      games = [
        dosbox
        nethack
        pokerth
        retroarch
      ];

      dev = [
        #vscodium
        vscodium-with-extensions
      ];

      # NOTE: Screen locker is configured via system config.
      window_manager = [
        albert
        gnome3.dconf-editor
        dmenu
        i3lock
        st
      ];

      office = [
        bluejeans-gui
        nixpkgs_bookworm.bookworm
        calibre
        evince
        libreoffice-fresh
        rdesktop
        slack
        tectonic
        texlive.combined.scheme-basic
        zathura
      ];

      fonts = [
        fira-code
        font-awesome-ttf
        font-manager
        fontforge-gtk
        gentium
        gentium-book-basic
        go-font
        gtk2fontsel
        gucharmap
        inconsolata
        iosevka
        libertine
        monoid
        noto-fonts
        noto-fonts-emoji
        roboto
        roboto-slab
        unifont
        unifont_upper
        victor-mono
      ];

      themes = [
        arc-theme
        arc-icon-theme
        lxappearance
        qt5ct
        qogir-theme
        vanilla-dmz
      ];

      multimedia = [
        audacity
        blender
        digikam
        feh
        #flashplayer-standalone
        gimp
        imagemagick
        inkscape
        obs-studio
        pavucontrol
        picard
        pulseeffects
        qt5.qtbase
        sxiv
        vlc
      ];

      # FIXME: These apps close immediately on startup (eiffel only?), complaining about GLX.
      broken = [
        baresip
        cool-retro-term
        glxinfo
        zoom-us
      ];

    };

    container = [
      curl
      file
      git
      go
      gotools
      horeb
      jq
      kubectl
      kubectx
      kubernetes-helm
      less
      gnumake
      neovim
      nodejs
      openssh
      skaffold
      tig
      tmux
      tree
      nixpkgs_xonsh.xonsh
    ];

  };
in
  {

    # A test environment containing only the hello package.
    env-hello = super.pkgs.buildEnv {
      name = "env-hello";
      meta.priority = 0;
      paths = with super.pkgs; [ hello ];
    };

    env-cli = super.pkgs.buildEnv {
      name = "env-cli";
      meta.priority = 0;
      paths = super.lib.lists.flatten (super.lib.attrsets.collect builtins.isList pkgGroups.CLI) ;
    };

    # A workstation environment for Linux.
    env-workstation = super.pkgs.buildEnv {
      name = "env-workstation";
      meta.priority = 0;
      paths =
        super.lib.lists.flatten (super.lib.attrsets.collect builtins.isList pkgGroups.CLI) ++
        super.lib.lists.flatten (super.lib.attrsets.collect builtins.isList pkgGroups.GUI)
        ;
    };

    # A workstation / development environment in a Docker container.
    env-container = super.pkgs.buildEnv {
      name = "env-container";
      meta.priority = 0;
      paths = pkgGroups.container;
    };

  }
