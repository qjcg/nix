{ pkgs, ... }:

{
  imports = [
    ./environment.nix
    ./hm.nix
    ./nix.nix
    ./nixpkgs.nix
    ./programs.nix
    ./services.nix
    ./system.nix
    ./time.nix
  ];
}
