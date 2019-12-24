self: super:

let

  pkgGroups = with super.pkgs; {

    CLI = {

      personal = [
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

      nix = [
        cachix
        nix-index
        nixops
        nix-bash-completions
        nix-zsh-completions
      ];

      shell = [
        bash_5
        bash-completion
      ];

      utilities = [
        aerc
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
        fossil
        hugo

        # Go.
        delve
        errcheck
        fly
        gnumake
        gocode
        gogetdoc
        gomodifytags
        gotags
        gotools
        protobuf
        upx

        mkcert
        mr

        # Node.
        nodejs
        now-cli

        postgresql_12

        # Python.
        pypy3
        python38Packages.cookiecutter
        python38Packages.ipython
        python38Packages.poetry

        janet
        racket
        sbcl
        tig
        universal-ctags
      ];

      # NOTE: VirtualBox is enabled at the system level.
      virt = [
        buildah
        conmon
        dive
        docker-compose
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
        #dbeaver
        vscodium
      ];

      # NOTE: Screen locker is configured via system config.
      window_manager = [
        albert
        dmenu
        i3lock
        st
      ];

      office = [
        bluejeans-gui
        bookworm
        calibre
        evince
        libreoffice-fresh
        rdesktop
        slack
        thunderbird-bin
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
        freetube
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

    mac = [
        go-4d
        horeb
        mtlcam

        alacritty
        ansible
        aria2
        bash-completion
        bash_5
        caddy
        #cmus
        coreutils
        delve
        docker-compose
        emacsMacport
        errcheck
        fdupes
        ffmpeg
        findutils
        fly
        fortune
        fossil
        fzf
        getent
        git
        gnugrep
        gnumake
        go
        go-font
        gopass
        gotags
        htop
        imagemagick
        inconsolata
        inkscape
        iosevka
        jq
        k3d
        kind
        kubectl
        kubectx
        kubernetes-helm
        lastpass-cli
        lsof
        mkcert
        mpv
        mtr
        neovim
        nethack
        nix-bash-completions
        nixops
        nodejs
        pandoc
        pdfcpu
        python38
        python38Packages.ipython
        #python38Packages.notebook
        python37Packages.pandas
        python38Packages.pip
        python38Packages.poetry
        qemu
        rclone
        rdesktop
        renameutils
        restic
        ripgrep
        rsync
        #sox
        stdenv
        #streamripper
        syncthing
        tig
        tmux
        tree
        universal-ctags
        unzip
        upx
        vscodium
        wtf
        youtube-dl
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

    env-workstation = super.pkgs.buildEnv {
      name = "env-workstation";
      meta.priority = 0;
      paths =
        super.lib.lists.flatten (super.lib.attrsets.collect builtins.isList pkgGroups.CLI) ++
        super.lib.lists.flatten (super.lib.attrsets.collect builtins.isList pkgGroups.GUI)
        ;
    };

    env-mac = super.pkgs.buildEnv {
      name = "env-mac";
      meta.priority = 0;
      paths = pkgGroups.mac;
    };

  }
