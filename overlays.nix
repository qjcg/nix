[ (self: super: 

  {

    # Adding my own packages.
    go-4d = super.callPackage ./packages/4d {};
    mtlcam = super.callPackage ./packages/mtlcam {};
    horeb = super.callPackage ./packages/horeb {};

    # Overriding existing packages.
    # Refs:
    #   - https://nixos.org/nixpkgs/manual/#sec-pkg-override
    #   - https://nixos.org/nixpkgs/manual/#sec-pkg-overrideAttrs
    st = super.st.override {
      conf = builtins.readFile ./files/st-config.h;
    } // super.st.overrideAttrs (oldAttrs: {
      meta.priority = "4";
    });

  }

)]
