[(self: super:

  {

    # Adding my own packages.
    go-4d = super.callPackage ./packages/4d {};
    mtlcam = super.callPackage ./packages/mtlcam {};
    horeb = super.callPackage ./packages/horeb {};

    # Overriding existing packages.
    # Refs:
    #   - https://nixos.org/nixpkgs/manual/#sec-pkg-override
    #   - https://nixos.org/nixpkgs/manual/#sec-pkg-overrideAttrs
    s-nail = super.callPackage ./packages/s-nail {};

    dunst = super.dunst.override {
      dunstify = true;
    };

    st = super.st.override {
      conf = builtins.readFile ./files/st-config.h;
      patches = [
        ./files/st-themed_cursor-0.8.1.diff
      ];
    } // super.st.overrideAttrs (oldAttrs: rec {
      meta.priority = "4";
    });

  }

)]
