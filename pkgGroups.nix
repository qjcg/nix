# Package Groups
{
  pkgs ? import <nixpkgs>,
  packages ? pkgs.callPackage ./packages {},
  ...
}:

with pkgs;
{

  CLI = {
    personal = [
      packages.go-4d
      packages.horeb
      packages.mtlcam

      # Clone not working ("No user exists for uid").
      # Known issue, see: https://github.com/NixOS/nixpkgs/issues/31762
      #packages.brightness

      #packages.loccount # FIXME: Needs make-based build
    ];


    nix = [
      nixops
      nix-bash-completions
      nix-zsh-completions
    ];

    utilities = [
      aerc
      ansible
      aria2
      bash_5
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
      virtualbox

      # FIXME: Not working with *system* kernel
      #linuxPackages_4_19.virtualbox
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
      retroarch
    ];

    dev = [
      dbeaver
    ];

    window_manager = [
      dmenu
      i3status-rust
      i3lock
      st

      # FIXME: slock fails with error on invocation ("getgrnam nogroup: group entry not found")
      #slock
    ];

    office = [
      bluejeans-gui
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
