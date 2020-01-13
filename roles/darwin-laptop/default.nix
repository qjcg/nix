{ pkgs, ... }:

{

  imports = [

    # Use the home-manager nix-darwin module.
    # This provides the home-manager.users.<user> options below.
    # Ref: https://rycee.gitlab.io/home-manager/index.html#sec-install-nix-darwin-module
    <home-manager/nix-darwin>

    ./environment.nix
    ./home.nix
    ./nixpkgs.nix
    ./programs.nix
    ./services.nix
    ./time.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
