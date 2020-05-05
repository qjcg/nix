{ lib, pkgs, secrets, ... }:

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
      "disk"
      "docker"
      "networkmanager"
      "vboxusers"
      "wheel"
    ];
  };

  home-manager.users.john = import ./john_hm.nix { inherit lib pkgs secrets; };

}
