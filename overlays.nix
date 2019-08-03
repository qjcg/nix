[ (self: super: 

  {

    # Adding my own packages.
    go-4d = super.callPackage ./packages/4d {};
    mtlcam = super.callPackage ./packages/mtlcam {};
    horeb = super.callPackage ./packages/horeb {};

    # Overriding existing packages.
    st = super.st.override {
      conf = builtins.readFile ./files/st-config.h;
    };

  }

)]
