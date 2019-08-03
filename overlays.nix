[ (self: super: 

  {
    st = super.st.override {
      conf = builtins.readFile ./files/st-config.h;
    };

  }

)]
