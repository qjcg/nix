{ pkgs }:

{
  # A cross-platform list of font packages.
  fontPkgs = with pkgs; [
    emacs-all-the-icons-fonts
    etBook
    fira-code
    go-font
    inconsolata-nerdfont
    iosevka
    julia-mono
    noto-fonts
    noto-fonts-emoji
    noto-fonts-extra
    roboto
    unifont
    victor-mono
  ];
}
