{ pkgs, secrets, ... }:

{

  imports = [ <home-manager/nixos> ];

  nix.trustedUsers = [ "root" "@wheel" ];

  users.users.john = {
    description = "John Gosset";
    isNormalUser = true;
    uid = 7777;
    extraGroups =
      [ "audio" "disk" "docker" "networkmanager" "vboxusers" "wheel" ];
  };

  home-manager.users.john = import ./john_hm.nix { inherit pkgs secrets; };

}
