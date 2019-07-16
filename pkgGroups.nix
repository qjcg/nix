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
      mtr
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
      pavucontrol
      pulseaudio
      pulseeffects
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
  };

  # FIXME: Use lib.attrsets.collect and lib.lists.flatten to combine lists here.
  # Ref:
  # - file:///home/john/.config/nixpkgs/_docs/nixpkgs-manual.html#function-library-lib.attrsets.collect
  # - file:///home/john/.config/nixpkgs/_docs/nixpkgs-manual.html#function-library-lib.lists.flatten
  GUI = {
    fonts = [
      fira-code
      fontconfig-penultimate
      gtk2fontsel
      iosevka
      inconsolata
      libertine
      roboto
    ];

    # FIXME: These apps close immediately on startup, complaining about GLX.
    broken = [
      alacritty
      baresip
      cool-retro-term
      glxinfo
      zoom-us
    ];

    utilities = [
      sent
    ];

    network = [
      wireshark
    ];

  };

}
