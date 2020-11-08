{ config, pkgs, ... }:
let
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
lib.attrsets.optionalAttrs stdenv.isLinux
  {

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

  } // lib.attrsets.optionalAttrs stdenv.isDarwin {

  fonts = {
    enableFontDir = true;
    fonts = fontPkgs;
  };

}
