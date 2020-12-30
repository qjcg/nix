{ config, lib, pkgs, ... }:

let
  inherit (pkgs.stdenv) isDarwin isLinux;

  fontPkgs = with pkgs; [
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

with lib;

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
  (mkIf isDarwin {
    fonts = {
      enableFontDir = true;
      fonts = fontPkgs;
    };
  })

]
