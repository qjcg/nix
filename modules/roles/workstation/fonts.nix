{ config, lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
  inherit (lib) mkIf mkMerge;

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
in
mkMerge [

  # Linux font configuration.
  (mkIf isLinux {
    fonts = {
      fonts = fontPkgs;
      enableDefaultFonts = true;
      fontDir.enable = true;

      fontconfig.enable = true;
      fontconfig.defaultFonts = {
        emoji = [ "Noto Color Emoji" "Noto Emoji" "Unifont" ];
        monospace = [ "JuliaMono" "Iosevka" "Victor Mono" "Go Mono" "Unifont" ];
        sansSerif = [ "Noto Sans" "Roboto Medium" "Unifont" ];
        serif = [ "Noto Serif" "Roboto Slab" "Unifont" ];
      };
    };
  })

  # Darwin font configuration.
  # See https://github.com/LnL7/nix-darwin/blob/master/modules/fonts/default.nix
  (mkIf isDarwin {
    fonts = {
      enableFontDir = true;
      fonts = fontPkgs;
    };
  })

]
