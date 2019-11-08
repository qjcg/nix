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

  retroarch = super.retroarch.override {
    cores = with self.libretro; [
      #beetle-lynx
      #beetle-vb
      #dosbox
      fba
      fceumm
      genesis-plus-gx
      mame
      mupen64plus
      nestopia
      prboom
      snes9x
      stella
    ];
  };

}
