# Package Groups
{
  pkgs,
  packages ? pkgs.callPackage ./packages {},
  ...
}:

with pkgs; 
{
  CLI = {
    nix = [
      nixops
      nix-bash-completions
      nix-zsh-completions
    ];

    utilities = [
      aerc
      ansible
      aria2
      davmail
      ed
      fdupes
      file
      fortune
      fzf
      gopass
      htop
      jq
      libfaketime
      lsof
      mkpasswd
      pandoc
      pv
      renameutils
      ripgrep
      tesseract
      tree
      unzip
      utillinux
      weechat

      # FIXME: Not compiling on fresh NixOS installation.
      packages.go-4d
      packages.horeb
      packages.mtlcam

      #packages.loccount # FIXME: Needs make-based build
    ];

    network = [
      bettercap
      dnsutils
      mtr
      nmap
    ];

    backup = [
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
      ctags
      fossil

      # For Go.
      delve
      gogetdoc
      gotags
      gotools
      errcheck
      upx

      mkcert
      mr
      nodejs
      python37Packages.cookiecutter
      python37Packages.poetry
      sbcl
      tig
    ];

    virt = [
      buildah
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
      chromium
      qutebrowser
    ];

    utilities = [
      gcolor3
      mesa
      sent
      tor-browser-bundle-bin
      wireshark
      xaos
      xorg.xev
      xscreensaver
      xwinwrap
    ];

    window_manager = [
      i3status-rust
      i3lock
      st

      # FIXME: dmenu_run exits after one keypress (Ubuntu 18.04, but NOT arch).
      dmenu

      # FIXME: slock fails with error on invocation ("getgrnam nogroup: group entry not found")
      #slock
    ];

    office = [
      bluejeans-gui
      libreoffice-fresh
      rdesktop
      slack
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
      feh
      gimp # gimp-with-plugins didn't compile! 2019-07-07
      imagemagick
      inkscape
      obs-studio
      pavucontrol
      pulseeffects
      sxiv
    ];

    # FIXME: These apps close immediately on startup, complaining about GLX.
    broken = [
      alacritty
      baresip
      cool-retro-term
      glxinfo
      zoom-us
    ];

  };
}
