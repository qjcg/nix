# Package Groups
{ pkgs, ... }:

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
      fortune
      fzf
      gopass
      jq
      libfaketime
      lsof
      mkpasswd
      pandoc
      pv
      renameutils
      ripgrep
      tesseract
      tmux
      tree
      unzip
      weechat
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
    ];

    devtools = [
      ctags
      delve
      fossil
      mkcert
      mr
      nodejs
      python37Packages.cookiecutter
      sbcl
      tig
      upx
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
    ];

  };


  GUI = {

    utilities = [
      gcolor3
      mesa
      sent
      tor-browser-bundle-bin
      wireshark
      xaos
      xscreensaver
      xwinwrap
    ];

    window_manager = [
      i3status-rust
      i3lock
      st

      # FIXME: dmenu_run exits after one keypress (Ubuntu 18.04, but NOT arch).
      #dmenu

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
      fontconfig-penultimate
      gtk2fontsel
      iosevka
      inconsolata
      libertine
      roboto
    ];

    multimedia = [
      feh
      gimp # gimp-with-plugins didn't compile! 2019-07-07
      imagemagick
      inkscape
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
