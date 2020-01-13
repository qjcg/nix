{ config, pkgs, ... }:

let
  darwin-path = "$HOME/.config/nixpkgs/machines/lmp-mtjgosset/configuration.nix"; 
in
{
  imports = [
    ../../roles/darwin-laptop

    # Should contain users.users.
    ../../secrets.nix
  ];

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 8;
  nix.buildCores = 0;

  nix.nixPath = [
    { darwin = darwin-path; }
    { darwin-config = darwin-path; }
    "$HOME/.nix-defexpr/channels"
  ];

}
