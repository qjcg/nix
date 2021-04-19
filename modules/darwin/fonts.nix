# Darwin font configuration.
# See https://github.com/LnL7/nix-darwin/blob/master/modules/fonts/default.nix
{ config, pkgs, ... }:

let
  inherit (import ../vars/fonts.nix { inherit pkgs; }) fontPkgs;
in
{
  config = {
    fonts = {
      enableFontDir = true;
      fonts = with pkgs; fontPkgs;
    };
  };
}
