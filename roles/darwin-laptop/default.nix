{ pkgs, ... }:

{
  imports = [
    ./environment.nix
    ./hm.nix
    ./nixpkgs.nix
    ./programs.nix
    ./services.nix
    ./system.nix
    ./time.nix
  ];
}
