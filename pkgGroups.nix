# Package Groups
{
  pkgs ? import <nixpkgs>,
  ...
}:

with pkgs;
{

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
      #cachix
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
      file
      fortune
      fzf
      gnupg
      gopass
      htop
      influxdb
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
      rlwrap
      sqlite
      telegraf
      tesseract
      tree
      unzip
      utillinux
      weechat
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
      youtube-dl
      youtube-viewer
    ];

    devtools = [
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

      # TODO: Re-enable poetry when fixed here: https://hydra.nixos.org/build/100467607
      # See also: https://github.com/NixOS/nixpkgs/issues/68361
      #python37Packages.poetry

      sbcl
      tig
      universal-ctags
    ];

    # NOTE: VirtualBox is enabled at the system level.
    virt = [
      buildah
      dive
      docker-compose
      kubectl
      kubernetes-helm
      minikube
      packer
      podman
      qemu
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
      tor-browser-bundle-bin
    ];

    utilities = [
      gcolor3
      libnotify
      mesa
      sent
      wireshark
      xaos
      xorg.xclock
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
      libretro.fba
      libretro.fceumm
      libretro.genesis-plus-gx
      libretro.mame
      libretro.mupen64plus
      libretro.nestopia
      libretro.prboom
      libretro.snes9x-next
      libretro.stella
    ];

    dev = [
      dbeaver
      vscode
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
      texlive.combined.scheme-medium
      zathura
    ];

    fonts = [
      fira-code
      font-awesome-ttf
      font-manager
      fontconfig-penultimate
      fontforge-gtk
      go-font
      gtk2fontsel
      inconsolata
      iosevka
      libertine
      monoid
      roboto
      unifont
      unifont_upper
    ];

    themes = [
      arc-icon-theme
      lxappearance
      # FIXME: re-enable qt5ct when building successfully
      #qt5ct
      qogir-theme
      vanilla-dmz
    ];

    multimedia = [
      audacity
      blender
      digikam
      feh
      #flashplayer-standalone # FIXME: re-enable when building successfully
      gimp # gimp-with-plugins didn't compile! 2019-07-07
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

    # FIXME: These apps close immediately on startup, complaining about GLX.
    broken = [
      baresip
      cool-retro-term
      glxinfo
      #zoom-us
    ];

  };

  vim = with pkgs.vimPlugins; {
    start = [
            ansible-vim
            awesome-vim-colorschemes
            changeColorScheme-vim
            fzf-vim
            goyo
            limelight-vim

            coc-css
            coc-git
            coc-go
            coc-highlight
            coc-html
            coc-json
            coc-nvim
            coc-prettier
            coc-python
            coc-snippets
            coc-yaml

            nerdtree

            vim-pandoc
            vim-pandoc-syntax

            #python-mode
            tagbar
            vim-beancount
            vim-go
            vim-jsx-pretty
            vim-nix
            vim-toml
    ];
    opt = [];
  };

}
