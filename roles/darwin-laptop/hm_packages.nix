{ pkgs, ... }:

{
  home.packages = with pkgs; [
      # personal
      go-4d
      horeb
      mtlcam

      # nix
      nixops

      # shell
      bash_5
      bash-completion
      nix-bash-completions
      xonsh

      # utilities
      ansible
      aria2
      fdupes

      # financial
      beancount
      fava


      alacritty
      caddy
      cmus
      coreutils
      delve
      docker-compose
      emacsMacport
      errcheck
      ffmpeg
      findutils
      fly
      fortune
      fossil
      fzf
      getent
      git
      glooctl
      gnugrep
      gnumake
      gnupg
      go
      go-font
      gopass
      gotags
      hey
      home-manager
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
      nodejs
      pandoc
      pdfcpu
      pstree
      python38
      python38Packages.ipython
      #python38Packages.notebook
      python37Packages.pandas
      python38Packages.pip
      #python38Packages.poetry
      qemu
      rclone
      rdesktop
      renameutils
      restic
      ripgrep
      rsync
      sox
      skaffold
      skopeo
      stdenv
      streamripper
      syncthing
      tig
      tmux
      tree
      universal-ctags
      unzip
      upx
      vault-bin
      vscodium
      wtf
      youtube-dl
    ];
}
