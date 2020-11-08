final: prev:

{
  retroarch = prev.retroarch.override {
    cores = with final.libretro; [
      beetle-lynx
      beetle-vb
      dosbox
      #fbalpha2012
      fceumm
      genesis-plus-gx
      mame
      mupen64plus
      nestopia
      prboom
      snes9x2010
      stella
    ];
  };
}
