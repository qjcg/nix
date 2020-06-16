{ pkgs, ... }:

{
  xdg.configFile = {
    "cmus/rc".source = ../../files/cmusrc;
    "emacs/init.el".source = ../../files/emacs/init.el;
    "fontconfig/conf.d/50-user-font-preferences.conf".source =
      ../../files/50-user-font-preferences.conf;
    "i3/workspace1.json".source = ../../files/workspace1.json;

    "i3/i3status-rust.toml" = {

      # Using pkgs.callPackage allows antiquotations to be expanded.
      text = pkgs.callPackage ../../files/i3status-rust_eiffel.toml.nix {
        inherit secrets;
      };
      onChange = "i3-msg restart";
    };
    "i3/i3status-rust_smallscreen.toml" = {

      # Using pkgs.callPackage allows antiquotations to be expanded.
      text =
        pkgs.callPackage ../../files/i3status-rust_eiffel-smallscreen.toml.nix {
          inherit secrets;
        };
      onChange = "i3-msg restart";
    };

    "nvim/coc-settings-example.json".source = ../../files/coc-settings.json;
    "s-nail/mailrc".text =
      pkgs.callPackage ../../files/mailrc.nix { inherit secrets; };
    "sxiv/exec/key-handler" = {
      executable = true;
      source = ../../files/sxiv-key-handler.sh;
    };
    "wtf/config.yml".source = ../../files/wtf-config.yml;
    "VSCodium/User/settings_example.json".source =
      ../../files/vscodium_settings_example.json;
    "xonsh/".source = ../../files/xonsh;
  };

  xdg.dataFile = {
    "fonts/Apl385.ttf" = {
      source = ../../files/fonts/Apl385.ttf;
      onChange = "fc-cache -f";
    };
  };

}
