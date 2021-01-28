{ pkgs, stdenv, }:
let
  inherit (stdenv.lib) fakeSha256;

  # Non-elisp packages required for various emacs features and modes.
  nonElispPackageDependencies = with pkgs; [
    nodePackages.mermaid-cli
    nodePackages.prettier
    nodePackages.vega-cli
    nodePackages.vega-lite
    tectonic
  ];

  # See https://github.com/peel/dotfiles/blob/a75b18f887b5f4ddd987d8988a0bdecab8d92cd7/overlays/20-emacs/emacs/default.nix
  elisp = src: file:
    pkgs.runCommand "${file}.el" { } ''
      mkdir -p $out/share/emacs/site-lisp
      cp -r ${src}/* $out/share/emacs/site-lisp/
    '';
in
# See https://github.com/nix-community/emacs-overlay/#extra-library-functionality
pkgs.emacsWithPackagesFromUsePackage {
  config = ../../../files/emacs/init.org;

  # Set to `false` to ONLY pull in packages with `:ensure`.
  alwaysEnsure = false;

  # Since I have `#+PROPERTY: header-args: emacs-lisp :tangle yes` at the top of init.org.
  alwaysTangle = true;

  # E.g. for packages not in ELPA, MELPA, etc.
  override = epkgs: epkgs // {

    elfeed-dashboard = elisp
      (pkgs.fetchFromGitHub {
        owner = "Manoj321";
        repo = "elfeed-dashboard";
        rev = "9e8e212da9ea471bdc58bc0a1f5932833029bb38";
        sha256 = "sha256-wJC+m4G2Jy+YbL23UT6Y24eDTMUE0IXjpcHZjC3KU6A=";
      }) "elfeed-dashboard";

    ob-go = elisp
      (pkgs.fetchFromGitHub {
        owner = "pope";
        repo = "ob-go";
        rev = "2067ed55f4c1d33a43cb3f6948609d240a8915f5";
        sha256 = "sha256-fN3dFDUl9SF6CLJ8ikYmJ3BvRwpuqX/pZiftWH1LPBk=";
      }) "ob-go";

    rigpa = elisp
      (pkgs.fetchFromGitHub {
        owner = "countvajhula";
        repo = "rigpa";
        rev = "932b83f12afb80f1ab2167c027c84a2b2aa45f17";
        sha256 = "sha256-dpUJgJMOuOPG1vdJXMf7y6ld/gIFSsyxVzqC2hwKb8g=";
      }) "rigpa";

    show-font-mode = elisp
      (pkgs.fetchFromGitHub {
        owner = "melissaboiko";
        repo = "show-font-mode";
        rev = "8503be7966d3bd8316039b5f49d3c37c7b97d10c";
        sha256 = "sha256-0Ifak9iRYT3a0vfksHYhwLi6etz7XUZhA5ozFK8zDaE=";
      }) "show-font-mode";

    # FIXME: Delete once a working version is in MELPA. At the time of
    # writing, v2.6.1 in melpa does not have
    # `shrface-default-keybindings`, while v2.6.3 (upstream) does.
    shrface = elisp
      (pkgs.fetchFromGitHub {
        owner = "chenyanming";
        repo = "shrface";
        rev = "89e9354fbd69635d7ad6c32a43736af4d2e59650";
        sha256 = "sha256-0OHD6dFZtqQpuWGn43q/U4BRF4dN/tyMQemCAkwED70=";
      }) "shrface";

    solo-jazz-theme = elisp
      (pkgs.fetchFromGitHub {
        owner = "cstby";
        repo = "solo-jazz-emacs-theme";
        rev = "3a2d1a0b404ba7c765526a1b76e0f1148ed8d0f2";
        sha256 = "sha256-Gk4kzKkHKUkzeJ0NfoTbc06l12pPHraxducm8ak32gE=";
      }) "solo-jazz-theme";

  };

  extraEmacsPackages = epkgs: with epkgs; [
    elfeed-dashboard
    ob-go
    rigpa
    show-font-mode
    shrface
    solo-jazz-theme
  ] ++ nonElispPackageDependencies;

}
