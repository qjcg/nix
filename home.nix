# home-manager configuration.
# See https://github.com/rycee/home-manager

# Below are machine-specific configurations.
# To choose a machine, run (for example):
#   home-manager -A luban switch
# Ref: home-manager(1)

let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;

  secrets = if builtins.pathExists ./secrets.nix then import ./secrets.nix
  else {
    openweathermap-api-key = "";
    openweathermap-city-id = "";
    work-user = "";
    git-name = "";
    git-email = "";
    s-nail-accounts = "";
  };

in
  {
    luban  = import ./machines/luban  { inherit pkgs lib secrets; };
    eiffel = import ./machines/eiffel { inherit pkgs lib secrets; };
  }
