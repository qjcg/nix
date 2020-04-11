{config, pkgs, secrets, ...}:

{
  imports = [
      (import ./configuration.nix {inherit config pkgs secrets;})
      ./hardware-configuration.nix
  ];
}
