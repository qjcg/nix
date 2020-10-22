{ config, home-manager, pkgs, secrets, ... }:

{

  imports = [ home-manager ];

  users.users.john = {
    description = "John Gosset";
    isNormalUser = true;
    uid = 7777;
    extraGroups =
      [ "audio" "disk" "docker" "networkmanager" "vboxusers" "wheel" ];
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.john =
    import ./john_hm.nix { inherit config pkgs secrets; };

}
