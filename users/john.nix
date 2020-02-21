{ config, secrets, ... }:

let
  pkgs = import <nixpkgs> {
    overlays = [
      (import ../packages)

      # TODO: Clearly distinguish/separate overlays (below) from packages.
      (import ../packages/neovim)
      (import ../packages/st)
      (import ../packages/sxiv)
      (import ../packages/vscodium-with-extensions)

      (import ../packages/overrides.nix)
      (import ../packages/environments.nix)
    ];
  };
in
{

  imports = [
    <home-manager/nixos>
  ];

  users.users.john = {
    description = "John Gosset";
    isNormalUser = true; 
    uid = 7777;
    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "vboxusers"
      "wheel"
    ];
  };

  home-manager.users.john = import ./john_hm.nix { inherit config pkgs secrets; };

}
