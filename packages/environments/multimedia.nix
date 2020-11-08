final: prev:

with prev;
{
  env-multimedia = buildEnv {
    name = "env-multimedia";
    meta.priority = 0;
    paths = [
      cmus
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
      pms
      pulseaudio
      youtube-viewer
    ];
  };
}
