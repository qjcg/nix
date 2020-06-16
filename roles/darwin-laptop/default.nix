{ pkgs, ... }:

{
  imports = [
    ./environment.nix
    (import ./hm.nix { inherit pkgs; })
    ./nix.nix
    ./nixpkgs.nix
    ./programs.nix
    ./services.nix
    ./system.nix
    ./time.nix
  ];
}
