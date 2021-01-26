{ pkgs, ... }:

with pkgs;

buildEnv {
  name = "env-multimedia";
  paths = [
    #cmus
    ffmpeg
    mpv
    sox
    streamripper
    youtube-dl
  ] ++ lib.lists.optionals stdenv.isLinux [
    alsaLib
    alsaPluginWrapper
    alsaPlugins
    alsaTools
    alsaUtils
    beets
    fluidsynth
    gource
    soundfont-fluid
    opusTools
    jg.custom.pms
    pulseaudio
    jg.newer.sbagen
    youtube-viewer
  ];
  meta = {
    priority = 0;
    description = "An environment for working with audio and video";
  };
}
