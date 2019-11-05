self: super:

{
  delve = super.delve.overrideAttrs (oldAttrs: rec {
    version = "1.3.2";
    src = self.fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v${version}";
      sha256 = "0i2sxr5d4ylakn93lmp65xwhaalbv01q4dih6viwnb9d0gq7p26x";
    };
  });

  dunst = super.dunst.override {
    dunstify = true;
  };


  # TODO: Uncomment when retroarch cores issue is fixed: https://github.com/NixOS/nixpkgs/pull/71108
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

}
