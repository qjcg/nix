{ pkgs, ... }:

{
  imports = [
    ./hm_gtk.nix
    ./hm_home.nix
    ./hm_programs.nix
    ./hm_services.nix
    ./hm_xdg.nix
    ./hm_xresources.nix
    ./hm_xsession.nix
  ];
}
