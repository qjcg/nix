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
      horeb
      mtlcam

      # Clone not working ("No user exists for uid").
      # Known issue, see: https://github.com/NixOS/nixpkgs/issues/31762
      #packages.brightness

      #packages.loccount # FIXME: Needs make-based build
    ];


    nix = [
      cachix
      nixops
      nix-bash-completions
      nix-zsh-completions
    ];

    utilities = [
      aerc
      ansible
      aria2
      bash_5
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

    network = [
      bettercap
      dnsutils
      iw
      mtr
      nmap
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

    devtools = [
      fossil

      # For Go.
      delve
      gnumake
      gogetdoc
      gotags
      gotools
      errcheck
      upx

      mkcert
      mr
      nodejs

      postgresql_11

      python37Packages.cookiecutter
      python37Packages.ipython
      python37Packages.poetry
      sbcl
      tig
      universal-ctags
    ];

    # NOTE: VirtualBox is enabled at the system level.
    virt = [
      buildah
      dive
      docker-compose
      packer
      podman
      qemu
      skopeo
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
      xorg.xev
      xscreensaver
      xwinwrap
    ];

    games = [
      nethack
      retroarch
    ];

    dev = [
      dbeaver
    ];

    # NOTE: Screen locker is configured via system config.
    window_manager = [
      dmenu
      i3status-rust
      i3lock
      st
    ];

    office = [
      bluejeans-gui
      evince
      libreoffice-fresh
      rdesktop
      slack
      thunderbird-bin
      zathura
    ];

    fonts = [
      fira-code
      font-awesome-ttf
      fontconfig-penultimate
      go-font
      gtk2fontsel
      inconsolata
      iosevka
      libertine
      roboto
      unifont
      unifont_upper
    ];

    themes = [
      arc-icon-theme
      lxappearance
      qt5ct
      qogir-theme
      vanilla-dmz
    ];

    multimedia = [
      blender
      feh
      flashplayer-standalone
      gimp # gimp-with-plugins didn't compile! 2019-07-07
      imagemagick
      inkscape

      obs-studio
      qt5.qtbase

      pavucontrol
      pulseeffects
      sxiv
      vlc
    ];

    # FIXME: These apps close immediately on startup, complaining about GLX.
    broken = [
      baresip
      cool-retro-term
      glxinfo
      zoom-us
    ];

  };
}
