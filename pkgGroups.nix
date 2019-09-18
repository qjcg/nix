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

      cmus

      ffmpeg
      fluidsynth
      soundfont-fluid

      mpv
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
      packer
      podman
      qemu
      skopeo
      tinyemu

      # FIXME: 2019-08-21 - TEMPORARILY disabled since build fails (xen related error).
      #vagrant

      # FIXME: vault disabled due to build error.
      #vault
    ];

  };


  GUI = {

    browsers = [
      browserpass
      chromium
      qutebrowser
      torbrowser
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
      audacity
      blender
      feh
      flashplayer-standalone
      gimp # gimp-with-plugins didn't compile! 2019-07-07
      imagemagick
      inkscape

      obs-studio
      qt5.qtbase

      pavucontrol
      picard
      pulseeffects
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
    opt = [];
  };

}
