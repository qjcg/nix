{ pkgs, lib, ... }:

pkgs.callPackage ../_workstation {} // {

      # NOTE: Home manager ALWAYS users <nixpkgs> for the package set.
      # To override, you can use:
      #    home-manager -I nixpkgs=~/.nix-defexpr/channels/unstable switch
      # Ref: https://github.com/rycee/home-manager/issues/376#issuecomment-419666167
      programs.bash.shellAliases = rec {
        hm = "home-manager -A luban -I nixpkgs=~/.nix-defexpr/channels/unstable";
        hms = "${hm} switch";
        hmRemoveAllBut3 = "${hm} generations | awk 'NR > 3 {print $5}' | xargs home-manager remove-generations && nix-collect-garbage";
      };

      xdg.configFile."i3/workspace1.json".source = ../../files/workspace1.json;
}
