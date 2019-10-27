self: super:

{
    dunst = super.dunst.override {
      dunstify = true;
    };
}
