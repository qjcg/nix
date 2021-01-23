{ config, pkgs, secrets, ... }:

{
  users.users.john = {
    description = "John Gosset";
    isNormalUser = true;
    uid = 7777;
    extraGroups = [
      "adbusers"
      "audio"
      "disk"
      "docker"
      "networkmanager"
      "vboxusers"
      "wheel"
    ];
  };

  programs.adb.enable = true;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.john =
    import ./john_hm.nix { inherit config pkgs secrets; };
}
