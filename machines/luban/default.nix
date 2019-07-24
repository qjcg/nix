{ pkgs, lib, ... }:

pkgs.callPackage ../_workstation {} // {

      # NOTE: Home manager ALWAYS uses <nixpkgs> for the package set.
      # To override, you can use:
      #    home-manager -I nixpkgs=~/.nix-defexpr/channels/unstable switch
      # Ref: https://github.com/rycee/home-manager/issues/376#issuecomment-419666167
      programs.bash.shellAliases = {
        hm = "home-manager -A luban";
      };

      xdg.configFile."i3/workspace1.json".source = ../../files/workspace1.json;
}
