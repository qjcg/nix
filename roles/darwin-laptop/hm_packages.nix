{ pkgs, ... }:

{
  #home.packages = with pkgs; [
  #  nixops

  #  # shell
  #  bash_5
  #  bash-completion
  #  nix-bash-completions
  #  xonsh

  #  # utilities
  #  ansible

  #  # Go programs, NOT building.
  #  # Ref: https://github.com/NixOS/nixpkgs/pull/83099
  #  # TODO: re-enable!
  #  #caddy
  #  delve
  #  errcheck
  #  #fly
  #  gotags
  #  #hey
  #  skopeo
  #  vault-bin

  #  cmus
  #  #docker-compose
  #  ffmpeg
  #  fossil
  #  go-font
  #  home-manager
  #  imagemagick
  #  inconsolata
  #  inkscape
  #  iosevka
  #  mpv
  #  nodejs

  #  (python38.withPackages (ps:
  #    with ps; [
  #      beautifulsoup4
  #      #black
  #      flake8
  #      ipython
  #      #isort
  #      mypy
  #      #notebook
  #      #pandas
  #      pip
  #      #poetry
  #      pylint
  #      python-dotenv
  #      requests
  #    ]))

  #  qemu
  #  sox
  #  stdenv
  #  streamripper
  #  universal-ctags
  #  upx
  #];
}
