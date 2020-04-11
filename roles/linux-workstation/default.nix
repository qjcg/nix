{ pkgs, ... }:

{
  imports = [
    ./hm_fonts.nix
    ./hm_gtk.nix
    ./hm_home.nix
    ./hm_manual.nix
    ./hm_programs.nix
    ./hm_services.nix
    ./hm_xdg.nix
    ./hm_xresources.nix
    ./hm_xsession.nix
  ];

  nix.gc = {
    automatic = true;
    dates = "01:00";
    options = "--delete-older-than 7d";
  };
}
