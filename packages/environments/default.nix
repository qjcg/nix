self: super:
let
  pkgs-flashplayer = import
    (fetchGit {
      url = "https://github.com/NixOS/nixpkgs-channels";
      ref = "nixos-20.03";
      rev = "add5529b3ee2df5035d7fb06120b74363a373be4";
    })
    { };

  pkgGroups = with super.pkgs; {

    CLI = {

      personal = [
        barr
        d4
        horeb
        mtlcam

        battery
        #gled
        goplot
        #hey
        k3c
        k3d
        loccount
        s-nail

        # Clone not working ("No user exists for uid").
        # Known issue, see: https://github.com/NixOS/nixpkgs/issues/31762
        #brightness
      ];

      nix =
        [ cachix nix-index nixFlakes nixops nixpkgs-fmt nix-bash-completions ];

      shell = [ bash_5 bash-completion xonsh ];

      utilities = [
        aria2
        benthos
        binutils
        ed
        elinks
        fd
        fdupes
        figlet
        file
        fortune
        fzf
        gnupg
        pinentry
        gopass
        htop
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
        tesseract
        toilet
        tree
        unzip
        utillinux
        wtf
      ];

      financial = [ beancount fava ];

      network =
        [ bettercap caddy dnsutils iw mtr nmap tailscale wireguard-tools ];

      backup = [ adb-sync rclone restic rsync syncthing ];

      devtools = [
        cue
        direnv
        fly
        fossil
        gnumake
        hugo

        # Go
        go

        delve
        errcheck
        gocode
        gogetdoc
        gomodifytags
        #gopls
        gotags
        gotools
        protobuf
        upx

        mkcert
        mr

        # Node
        nodejs-12_x
        now-cli
        yarn
        yarn2nix

        postgresql_12

        # Python
        pypy3

        (python38.withPackages (ps:
          with ps; [
            beautifulsoup4
            ipython
            isort
            mypy
            pylint
            python-dotenv
            requests
          ]))

        cookiecutter
        python37Packages.black
        poetry

        # Lisp / Scheme
        emacs
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
        cri-tools
        dive
        docker-compose
        #glooctl
        helm
        k3d
        kind
        kompose
        kubectl
        kubectx
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

      browsers = [ browserpass chromium firefox qutebrowser surf torbrowser ];

      utilities = [
        gcolor3
        graphviz
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

      games = [ dosbox nethack pokerth retroarch ];

      #big-games = [
      #  openarena
      #  urbanterror
      #];

      dev = [
        #jmigpin-editor
        #plan9port
        vscodium-with-extensions
      ];

      # NOTE: Screen locker is configured via system config.
      window_manager = [ albert gnome3.dconf-editor dmenu i3lock st ];

      office = [
        bookworm
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
        noto-fonts
        noto-fonts-emoji
        roboto
        roboto-slab
        unifont
        unifont_upper
        victor-mono
      ];

      themes = [ arc-icon-theme lxappearance qt5ct qogir-theme vanilla-dmz ];

      multimedia = [
        audacity
        blender
        digikam
        feh
        pkgs-flashplayer.flashplayer-standalone
        gimp
        imagemagick
        inkscape
        obs-studio
        pavucontrol
        picard
        pulseeffects
        qt5.qtbase
        strawberry
        sxiv
        vlc
      ];

      # FIXME: These apps close immediately on startup (eiffel only?), complaining about GLX.
      broken = [ baresip cool-retro-term glxinfo zoom-us ];

    };

    container = [
      curl
      file
      git
      go
      gotools
      helm
      horeb
      jq
      kubectl
      kubectx
      less
      gnumake
      neovim
      nodejs
      openssh
      skaffold
      tig
      tmux
      tree
      xonsh
    ];

  };
in
{
  env-financial = (import ./financial.nix self super).env-financial;
  env-go = (import ./go.nix self super).env-go;
  env-k8s = (import ./k8s.nix self super).env-k8s;
  env-neovim = (import ./neovim.nix self super).env-neovim;
  env-nix = (import ./nix.nix self super).env-nix;
  env-multimedia = (import ./multimedia.nix self super).env-multimedia;
  env-personal = (import ./personal.nix self super).env-personal;
  env-python = (import ./python.nix self super).env-python;
  env-ruby = (import ./ruby.nix self super).env-ruby;
  env-shell = (import ./shell.nix self super).env-shell;
  env-tools = (import ./tools.nix self super).env-tools;
  env-vscodium = (import ./vscodium.nix self super).env-vscodium;

  # A test environment containing only the hello package.
  env-hello = super.pkgs.buildEnv {
    name = "env-hello";
    meta.priority = 0;
    paths = with super.pkgs; [ hello ];
  };

  env-cli = super.pkgs.buildEnv {
    name = "env-cli";
    meta.priority = 0;
    paths = super.lib.lists.flatten
      (super.lib.attrsets.collect builtins.isList pkgGroups.CLI);
  };

  # A workstation environment for Linux.
  env-workstation = super.pkgs.buildEnv {
    name = "env-workstation";
    meta.priority = 0;
    paths = super.lib.lists.flatten
      (super.lib.attrsets.collect builtins.isList pkgGroups.CLI)
    ++ super.lib.lists.flatten
      (super.lib.attrsets.collect builtins.isList pkgGroups.GUI);
  };

  # A workstation / development environment in a Docker container.
  env-container = super.pkgs.buildEnv {
    name = "env-container";
    meta.priority = 0;
    paths = pkgGroups.container;
  };

}
