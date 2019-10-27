self: super:

{
    dunst = super.dunst.override {
      dunstify = true;
    };

    # TODO: Figure out syntax for enabling various cores (below does NOT work).
    #retroarch = super.retroarch.override {
    #  cores = [
    #    fba
    #    genesis-plus-gx
    #    mame
    #    mupen64plus
    #    nestopia
    #    snes9x-next
    #    stella
    #  ];
    #};

    st = super.st.override {
      conf = builtins.readFile ../files/st-config.h;
    };
}
