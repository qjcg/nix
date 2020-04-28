{ pkgs, ... }:

{
  home.packages = with pkgs; [
      # personal
      #go-4d

      # Go packages NOT building on macos.
      # TODO: Re-enable!
      #horeb
      #mtlcam

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


      # Go programs, NOT building.
      # Ref: https://github.com/NixOS/nixpkgs/pull/83099
      # TODO: re-enable!
      #caddy
      delve
      errcheck
      #fly
      gopass
      gotags
      #hey
      #k3d
      kind
      kubectl
      kubectx
      kubernetes-helm
      #mkcert
      pdfcpu
      skaffold
      skopeo
      #syncthing
      vault-bin
      #wtf


      alacritty
      cmus
      coreutils
      #docker-compose
      #emacsMacport
      ffmpeg
      findutils
      fortune
      fossil
      fzf
      getent
      git
      gnugrep
      gnumake
      gnupg
      go
      go-font
      home-manager
      htop
      imagemagick
      inconsolata
      inkscape
      iosevka
      jq
      lastpass-cli
      lsof
      mpv
      mtr
      neovim
      nethack
      nodejs
      pandoc
      pstree

      (python38.withPackages (ps: with ps; [
        beautifulsoup4
        #black
        flake8
        ipython
        #isort
        mypy
        #notebook
        #pandas
        pip
        #poetry
        pylint
        python-dotenv
        requests
      ]))

      qemu
      rclone
      rdesktop
      renameutils
      restic
      ripgrep
      rsync
      sox
      stdenv
      streamripper
      tig
      tmux
      tree
      universal-ctags
      unzip
      upx
      #vscodium
      youtube-dl
    ];
}
