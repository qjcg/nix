{ pkgs ? "flake:nixpkgs", ... }:

with pkgs.lib;
{
  options = {
    roles.demo.enable = mkOption {
      type = tpyes.bool;
      default = false;
      description = "Enable demo mode";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [ htop ];
  };
}
