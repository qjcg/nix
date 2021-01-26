{ pkgs, ... }:

pkgs.retroarch.override {
  cores = with pkgs.libretro; [
    beetle-lynx
    beetle-vb
    dosbox
    fbalpha2012
    fceumm
    genesis-plus-gx
    #mame  # FIXME: Disable due to failed build 2021-01-26.
    mupen64plus
    nestopia
    prboom
    snes9x2010
    stella
  ];
}
