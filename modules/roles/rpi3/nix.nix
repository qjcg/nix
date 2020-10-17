{ lib, ... }:

{
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  nix.maxJobs = lib.mkDefault 4;
}
