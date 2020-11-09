{ pkgs, ... }:

pkgs.retroarch.override {
  cores = with pkgs.libretro; [
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
}
